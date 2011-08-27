# Contactology::Mailer

This library provides an ActionMailer-based hook into sending [transactional campaigns][transactional-campaigns] through [Contactology][contactology].

## Example

```ruby
    # config/initializers/contactology.rb
    Contactology.key = 'MyContactologyApiKey'

    # app/mailers/user_mailer.rb
    class UserMailer < Contactology::Mailer
      def welcome(user)
        # Sets the transactional campaign recipients
        recipients user.email

        # Sets the "replacements" for the campaign
        body :user_name => user.name, :email => user.email
      end
    end

    # Sends via a Contactology "welcome" transaction campaign.
    # The "welcome" campaign would be created through another means.
    UserMailer.deliver_welcome(User.first)
```

## Installation

Installation is done through Rubygems with `gem install contactology-mailer`.

## More information

* [contactology gem][contactology-gem]: Learn more about the contactology gem running behind this mailer
* [Contactology API][contactology-api]: Read the documentation on the current Contactology API

[contactology]: http://www.contactology.com/
[contactology-api]: http://www.contactology.com/email-marketing-api/
[contactology-gem]: https://github.com/nbibler/contactology
[transactional-campaigns]: http://help.contactology.com/discussions/api/4-can-i-send-transactional-emails-with-contactology
