# kohrVid.com

## ⚠️ Archive Notice

This is the repo for v2 of kohrVid.com. As of v3 (launched in July 2024), the
project will be closed source.

The site has also changed hosts as I've found Heroku quite frustrating to deal
with over the years. The new version is dockerised and the backend and frontend
have been split into separate repos.

<!-- vim-markdown-toc GFM -->

* [Prerequisites](#prerequisites)
* [Set up](#set-up)
* [Run locally](#run-locally)
* [Deploy to production](#deploy-to-production)
* [Run test suite](#run-test-suite)

<!-- vim-markdown-toc -->

## Prerequisites

* Ruby v2.6+
* Node v12+
* Postgres v9.6+


## Set up

To install, first ensure that the assets version is set in your environment:

    ASSETS_VERSION=1.1

Then run:

    rails db:create
    rails db:migrate
    gem install bundler
    bundle install
    rails webpacker:install
    rails webpacker:install:react


## Run locally

To run the app locally run:

    rails s


## Deploy to production

This is really more of a note to self as I seem to forget this _everytime I
update the site._ The assets should compile automatically during deployment. If
they don't, I could just run:

    heroku run bundle exec rake assets:precompile RAILS_ENV=$ENV -a $appName
    heroku run bundle exec rake webpacker:compile RAILS_ENV=$ENV -a $appName


This depends on the following buildpacks:

  * heroku/ruby
  * heroku/nodejs

## Run test suite

Tests are mostly written in RSpec

    rspec

Guard is configured to run when changes are made to specific tests:

    guard
