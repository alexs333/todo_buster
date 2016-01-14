# TODO Buster

Tired of developers adding TODOs in your code that are actually never get done?  Find those using this gem old TODOs and fail the build! 
This gem can to be included as a part of your continuous integration build or you can run it on add-hock basis.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'todo_buster'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install todo_buster

## Usage

To use simply run:

    $ bust_todos

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alexs333/todo_buster.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
