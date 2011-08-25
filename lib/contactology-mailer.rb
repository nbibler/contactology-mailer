require 'contactology'
require 'action_mailer'
require 'contactology-mailer/version'

module Contactology
  class Mailer < ActionMailer::Base
    UnrecognizedCampaignError = Class.new(RuntimeError)

    private

    def self.method_missing(method_symbol, *parameters, &block)
      if method_symbol.id2name.match(/^deliver_([_a-z]\w*)/)
        deliver_contactology_mail($1, *parameters)
      else
        super
      end
    end

    def self.deliver_contactology_mail(method, *params)
      mail = new
      mail.__send__(method, *params)

      return unless perform_deliveries

      if delivery_method == :test
        deliveries << (mail.mail ? mail.mail : mail)
      else
        all_recipients = [mail.recipients].flatten.compact
        results = all_recipients.collect do |recipient|
          mail.recipients = recipient
          call_api!(mail, method)
        end
        results.all? { |r| r.is_a?(TrueClass) }
      end
    end

    def self.call_api!(mail, method)
      if campaign = Contactology::Campaign.find_by_name(method)
        campaign.send_campaign(
          Struct.new(:email).new(mail.recipients), {
          :replacements => mail.body
        }).successful?
      else
        raise UnrecognizedCampaignError, "No Contactology campaign found named \"#{method}\"."
      end
    end
  end
end
