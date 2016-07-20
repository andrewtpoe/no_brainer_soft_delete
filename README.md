# NoBrainer Soft Delete

This gem adds soft delete functionality inspired by [Paranoia](https://github.com/rubysherpas/paranoia) to NoBrainer for the NoSQL database RethinkDB.



## Installation

This gem requires you to use [RethinkDB](https://rethinkdb.com/) and the gem [NoBrainer](https://github.com/nviennot/nobrainer) in your application.

To install, add this line to your application's Gemfile and run bundle:

```ruby
gem 'nobrainer_soft_delete'
```

In the model that you would like to add soft delete functionality to, add this line of code:

```ruby
  include NoBrainer::Document::SoftDelete
```

That's all there is to it. 

## Usage


## Development

To install the dependencies for this gem on your local machine, run `$ bundle install`.

To run the test suite run use `$ bundle exec rake test`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/andrewtpoe/nobrainer_soft_delete.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
