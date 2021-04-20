# Contributing to IndieWeb Endpoints

I'd love to have your help improving IndieWeb Endpoints! If you'd like to pitch in, you can do so in a number of ways:

1. Look through open [Issues](https://github.com/jgarber623/indieweb-endpoints.cc/issues).
1. Review any open [Pull Requests](https://github.com/jgarber623/indieweb-endpoints.cc/pulls).
1. [Fork IndieWeb Endpoints](#get-set-up-to-contribute) and fix an open Issue or add your own feature.
1. File new Issues if you have a good idea or see a bug and don't know how to fix it yourself. _Only do this after you've made sure the behavior or problem you're seeing isn't already documented in an open Issue._

I definitely appreciate your interest in (and help improving) IndieWeb Endpoints. Thanks!

## Installation

IndieWeb Endpoints is written in [Ruby](https://www.ruby-lang.org) (version 2.7.3) and uses the [Bundler](https://bundler.io) gem to manage Ruby dependencies. Install Ruby 2.7.3 using a method of your choice (e.g. [rbenv](https://github.com/rbenv/rbenv), [chruby](https://github.com/postmodern/chruby), or [RVM](https://rvm.io)).

Once you've installed Ruby 2.7.3, install Bundler and the project's dependencies by running:

```sh
gem install bundler

bundle install
```

To start the app locally in development mode, run:

```sh
bin/run
```

This will fire up a server and you'll have the app running locally at `http://localhost:9393/`.

## Get set up to contribute

Contributing to IndieWeb Endpoints is pretty straightforward:

1. Fork the IndieWeb Endpoints repo and clone it.
1. Install development dependencies by running `bundle install` from the root of the project.
1. Create a feature branch for the issue or new feature you're looking to tackle: `git checkout -b your-descriptive-branch-name`.
1. _Write some code!_
1. Commit your changes: `git commit -am 'Add some new feature or fix some issue'`.
1. Push the branch to your fork of IndieWeb Endpoints: `git push origin your-descriptive-branch-name`.
1. Create a new Pull Request and I'll give it a look!

## Code Style

IndieWeb Endpoints' formatting guidelines are defined in the `.editorconfig` file which uses the [EditorConfig](https://editorconfig.org) syntax. There are [a number of great plugins for a variety of editors](https://editorconfig.org/#download) that utilize the settings in the `.editorconfig` file. Using EditorConfig will make your time spent coding a little bit easier.

Your bug fix or feature addition won't be rejected if it runs afoul of any (or all) of these guidelines, but following the guidelines will definitely make everyone's lives a little easier.
