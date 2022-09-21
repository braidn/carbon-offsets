# Carbon Credits APP

A simple API to manage Carbon Offset consumption and Credits

## Description

API that's powering folks to purchase carbon credits, add credits, etc.
If you don't happen to know what a carbon credit is:

[https://en.wikipedia.org/wiki/Carbon_credit][cc]

## Getting Started

### Dependencies

* Ruby 3.x
* Bundler > 2.1
* PostgreSQL (libpq)

### Installing

* Set pg and sequel.pg to use libpq

       bundle config --local build.pg --with-opt-dir="/opt/homebrew/opt/libpq"
       bundle config --local build.sequel_pg --with-opt-dir="/opt/homebrew/opt/libpq"

* Install all Gems

      bundle install

### Running Tests

* Run all tests

      rake

### Running the App

* How to run the program
* Step-by-step bullets

## Acknowledgments

* [Roda-Sequel-Stack](https://github.com/jeremyevans/roda-sequel-stack)

[cc]: https://en.wikipedia.org/wiki/Carbon_credit
