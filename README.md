# kohrVid.com

This is the repo for my site.

<!-- vim-markdown-toc GFM -->

* [Prerequisites](#prerequisites)
* [Set up](#set-up)
* [Run locally](#run-locally)
* [Deploy to production](#deploy-to-production)

<!-- vim-markdown-toc -->

## Prerequisites

* Ruby v2.6+
* Node v12+
* Postgres v9.6+


## Set up

To install run:

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


This depends on the following buildpacks:

  * heroku/ruby
  * heroku/nodejs
