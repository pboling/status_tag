# StatusTag

SRP:  Provides a method signature that can be splatted to Rails' `content_tag_for` to create labels.
Flexible: not explicitly dependent on bootstrap or any other style framework.

| Project                 |  StatusTag    |
|------------------------ | ----------------- |
| gem name                |  status_tag   |
| license                 |  MIT              |
| expert support          |  [![Get help on Codementor](https://cdn.codementor.io/badges/get_help_github.svg)](https://www.codementor.io/peterboling?utm_source=github&utm_medium=button&utm_term=peterboling&utm_campaign=github) |
| download rank               |  [![Total Downloads](https://img.shields.io/gem/rt/status_tag.svg)](https://rubygems.org/gems/status_tag) |
| version                 |  [![Gem Version](https://badge.fury.io/rb/status_tag.png)](http://badge.fury.io/rb/status_tag) |
| dependencies            |  [![Dependency Status](https://gemnasium.com/pboling/status_tag.png)](https://gemnasium.com/pboling/status_tag) |
| code quality            |  [![Code Climate](https://codeclimate.com/github/pboling/status_tag.png)](https://codeclimate.com/github/pboling/status_tag) |
| inline documenation     |  [![Inline docs](http://inch-ci.org/github/pboling/status_tag.png)](http://inch-ci.org/github/pboling/status_tag) |
| continuous integration  |  [![Build Status](https://secure.travis-ci.org/pboling/status_tag.png?branch=master)](https://travis-ci.org/pboling/status_tag) |
| test coverage           |  [![Coverage Status](https://coveralls.io/repos/pboling/status_tag/badge.png)](https://coveralls.io/r/pboling/status_tag) |
| homepage                |  [on Github.com][homepage] |
| documentation           |  [on Rdoc.info][documentation] |
| live chat               |  [![Join the chat at https://gitter.im/pboling/status_tag](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/pboling/status_tag?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge) |
| Spread ~♡ⓛⓞⓥⓔ♡~      |  [🌏](https://about.me/peter.boling), [👼](https://angel.co/peter-boling), [:shipit:](http://coderwall.com/pboling), [![Tweet Peter](https://img.shields.io/twitter/follow/galtzo.svg?style=social&label=Follow)](http://twitter.com/galtzo), [🌹](https://nationalprogressiveparty.org) |

[semver]: http://semver.org/
[pvc]: http://docs.rubygems.org/read/chapter/16#page74
[railsbling]: http://www.railsbling.com
[peterboling]: http://www.peterboling.com
[coderbits]: https://coderbits.com/pboling
[coderwall]: http://coderwall.com/pboling
[documentation]: http://rdoc.info/github/pboling/status_tag/frames
[homepage]: https://github.com/pboling/status_tag


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'status_tag'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install status_tag

## Usage

Example:

```ruby
# Recommend putting the following in a helper method.
# signature may be nil, which is an indication that the chosen label was marked as a noop.
text, signature = StatusTag::Presenter.status_tag_signature_for(:span, user, "state")
if signature
  content_tag_for(*signature) do
    text
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/status_tag.

