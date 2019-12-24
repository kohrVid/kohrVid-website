# kohrVid.com

This is the repo for my site.

<!-- vim-markdown-toc GFM -->

* [Prerequisites](#prerequisites)
* [Set up](#set-up)
* [Run locally](#run-locally)

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
    yarn install --check-files
    bundle install
    rails webpacker:install
    rails webpacker:install:react
    rails generate react:install


## Run locally

To run the app locally run:

    rails s
