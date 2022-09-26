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

### The Datastore

It's recommended to use a container for PostgreSQL or perhaps a 'cloud environment'.
Export the following two environment variables with relevant PostgreSQL connection strings:

        APP_TEST_DATABASE_URL
        APP_DEV_DATABASE_URL

* To create and migrate a database depending on environment:

        rake {dev|prod|test}_up

* To seed an environment copy all items from seed.rb and paste into an irb instance for the environment:

        rake  {dev|prod|test}_irb

* To drop a database and all data within it:

        rake {dev|prod|test}_down

### Running Tests

* Run all tests

        rake


### Running the App

* Install any rack server gem ([Rackup][ru], [Mr Sparkle][ms], [Shotgun][sh])
* Run the above server gem using the provided `config.rb` eg:

        rackup config.rb

## Acknowledgments

* [Roda-Sequel-Stack](https://github.com/jeremyevans/roda-sequel-stack)

[cc]: https://en.wikipedia.org/wiki/Carbon_credit
[ru]: https://github.com/rack/rackup
[ms]: https://github.com/MicahChalmer/mr-sparkle
[sh]: https://github.com/rtomayko/shotgun
