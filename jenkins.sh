#!/bin/bash -x
bundle install --path "${HOME}/bundles/${JOB_NAME}" --deployment
bundle exec rake db:setup
bundle exec rake db:migrate
bundle exec rake stats
bundle exec rake spec
