# NoBrainer Soft Delete

This gem adds soft delete functionality inspired by [Paranoia](https://github.com/rubysherpas/paranoia) to NoBrainer for the NoSQL database RethinkDB.

## Installation & Use

This gem requires you to use [RethinkDB](https://rethinkdb.com/) and the gem [NoBrainer](https://github.com/nviennot/nobrainer) in your application.

To install, add this line to your application's Gemfile and run bundle:

```ruby
gem 'no_brainer_soft_delete'
```

In the model that you would like to add soft delete functionality to, add this line of code directly below your NoBrainer includes:

```ruby
  include NoBrainerSoftDelete
```

That's all there is to it. This single line of code does several things for you:
  - It adds a `deleted_at` field to your model (with an index)
  - It scopes your default queries to documents that do not have a `deleted_at` value
  - It provides access to several class and instance level methods.

__Methods available from NoBrainerSoftDelete:__

`Model.with_deleted`

This method removes *all* scopes, then applies a scope reflecting that documents should be included regardless of the value held at `deleted_at`. It is important to note, this should be the first method called in a query chain as it will override anything prior to it.

```ruby
# Good
Model.with_deleted.where(value: 'query_for')

# Bad
Model.where(value: 'query_for').with_deleted
```

`Model.only_deleted`

This method removes *all* scopes,, then applies a scope reflecting that documents only be included in the query if the have a value saved to `deleted_at`. It is important to note, this should be the first method called in a query chain as it will override anything prior to it.

`Model.restore(id)`

This method locates a document and restores it.

`instance.deleted?`

Returns a boolean indicating whether or not the document has been soft deleted.

`instance.destroy`

Saves the value of `Time.now` to the `deleted_at` field and renders the document soft deleted. Also performs before/ after destroy callbacks. Returns a boolean indicating whether the operation was successful.

`instance.really_destroy!`

Performs the original destroy operation and completely removes the document from the database. Any instance that has this method called will no longer exist. Use with caution.

`instance.restore`

Erases the value saved to `deleted_at` by setting it to nil. The effectively "un-deletes" the document, and makes it readily accessible again.

## Development

To install the dependencies for this gem on your local machine, run `$ bundle install`.

To run the specs use first start your rethinkdb server, then run `$ bundle exec rspec`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/andrewtpoe/no_brainer_soft_delete. Please refer to the contributing guide for best practices.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
