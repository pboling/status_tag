# StatusTag

SRP:  Provides a method signature that can be splatted to Rails' `content_tag_for` to create labels.
Flexible: not explicitly dependent on bootstrap or any other style framework.

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

