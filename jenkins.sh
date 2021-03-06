#!/bin/bash -xe

# Gemfile.lock is not in source control because this is a gem
rm -f Gemfile.lock

git clean -fdx

bundle install --path "${HOME}/bundles/${JOB_NAME}"

if [[ ${GIT_BRANCH} != "origin/master" ]]; then
  bundle exec govuk-lint-ruby --format clang
fi

bundle exec rspec spec
