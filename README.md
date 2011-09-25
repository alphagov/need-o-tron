# Welcome to Need-o-Tron

For an overview of the need-o-tron visit [Richard Pope's introductory blog post](http://digital.cabinetoffice.gov.uk/introducing-the-needotron)

## Getting set up

Need-o-Tron is a Rails 3.1 application. It is built with ruby 1.9.2 and isn't 
guaranteed to work with any previous versions. To get up and running you'll
need ruby and bundler installed. It should then just be a case of running:

`bundle install
rake db:setup
rails server`

## Authentication 

Need-o-tron designed to work as part of a suite of applications, authenticating 
against an OAuth provider such as [Sign-on-o-tron](https://github.com/alphagov/sign-on-o-tron)

It does that via the [GDS-SSO](https://github.com/alphagov/gds-sso) gem. See that 
project's README for configuration details. If you don't want to authenticate
against a separate app there's also a basic strategy for development use that will
simply use the first user in your database. To set that up you'll want something
like:

`% rails console
User.create(:name => 'First User', :email => 'first@user.com', :uid => 1)
exit`
