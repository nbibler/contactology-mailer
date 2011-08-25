# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "contactology-mailer/version"

Gem::Specification.new do |s|
  s.name        = "contactology-mailer"
  s.version     = Contactology::Mailer::VERSION
  s.authors     = ["Nathaniel Bibler"]
  s.email       = ["git@nathanielbibler.com"]
  s.homepage    = "https://github.com/nbibler/contactology-mailer"
  s.summary     = %q{An ActionMailer interface to sending Contactology transactional campaigns}
  s.description = %q{Using the contactology gem, this library provides a Contactology::Mailer to provide simple integration with sending Contactology transactional campaigns.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'contactology', '~>1.1'
  s.add_dependency 'actionmailer', '~>2.3.0'
end
