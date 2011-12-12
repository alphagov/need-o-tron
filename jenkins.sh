#!/bin/bash -x

export RAILS_ENV=test

bundle install --path "${HOME}/bundles/${JOB_NAME}"
bundle exec rake db:setup
bundle exec rake db:migrate
bundle exec rake stats
FACTER_govuk_platform=test bundle exec rake ci:setup:rspec spec
