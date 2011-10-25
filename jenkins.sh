#!/bin/bash -x
bundle install --path "${HOME}/bundles/${JOB_NAME}"
bundle exec rake db:setup
bundle exec rake db:migrate
bundle exec rake stats
bundle exec rake ci:setup:rspec spec
