# CheckXcodeXmls

Script that checks xib and storyboard files for:
    - constraints identifiers.
    - that files are using autolayout

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'check_xcode_xmls'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install check_xcode_xmls

## Usage

Usage:
`check-xcode-xmls -i <ignore regex> [--check-constraints-identifiers] [--check-use-autolayout] <target directory>`

Example for running from the project directory and ignore any file path that contains "Ignore" or "Debug".
`check-xcode-xmls -i "Ignore|Debug" --check-constraints-identifiers --check-use-autolayout .`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/check_xcode_xmls. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CheckXcodeXmls project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/check_xcode_xmls/blob/master/CODE_OF_CONDUCT.md).
