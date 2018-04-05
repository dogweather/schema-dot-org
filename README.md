[![Gem Version](https://badge.fury.io/rb/schema_dot_org.svg)](https://badge.fury.io/rb/schema_dot_org) [![Maintainability](https://api.codeclimate.com/v1/badges/e0c60b4cbc998563a484/maintainability)](https://codeclimate.com/github/dogweather/schema-dot-org/maintainability)

# SchemaDotOrg

Let's create [Structured Data](https://developers.google.com/search/docs/guides/intro-structured-data) that's correct,
every single time.

> Google Search works hard to understand the content of a page. You can help us by providing explicit clues about the meaning of a page . . .

## Usage

Let's say you have a Rails app. If you put this in a controller:

```ruby
@public_law = Organization.new(
  name:             'Public.Law',
  founder:           Person.new(name: 'Robb Shecter'),
  founding_date:     Date.new(2009, 3, 6),
  founding_location: Place.new(address: 'Portland, OR'),
  email:            'say_hi@public.law',
  url:              'https://www.public.law',
  logo:             'https://www.public.law/favicon-196x196.png'
  )
```

...and this in a template:

```html
<%= @public_law %>
```

...you'll get this HTML:

```html
<script type="application/ld+json">
{
  "@context": "http://schema.org",
  "@type": "Organization",
  "name": "Public.Law",
  "email": "say_hi@public.law",
  "url": "https://www.public.law",
  "logo": "https://www.public.law/favicon-196x196.png",
  "foundingDate": "2009-03-06",
  "founder": {
    "@type": "Person",
    "name": "Robb Shecter"
  },
  "foundingLocation": {
    "@type": "Place",
    "address": "Portland, OR"
  }
</script>
```

Strong typing is at work here. SchemaDotOrg will validate your code, and if correct, will generate Schema.org JSON-LD markup.
 Notice how the `foundingDate` is in the required ISO-8601 format. [The founding date must be a Ruby
Date object](https://github.com/dogweather/schema-dot-org/blob/master/lib/schema_dot_org/organization.rb#L11) and so we can ensure correct formatting. In the same way, the `foundingLocation` is a `Place`
which adds the proper `@type` attribute.

### You cannot create invalid markup

E.g., If you use the wrong type or try to set an unknown attribute, SchemaDotOrg will
refuse to create the incorrect JSON-LD. Instead, you'll get a message explaining
the problem:

```ruby
Place.new(address: 12345)
# => ArgumentError: Address is class Integer, not String

Place.new(
  address: '12345 Happy Street',
  author:  'Hemmingway'
)
# => NoMethodError: undefined method `author='
```

This type safety comes from the [ValidatedObject gem](https://github.com/dogweather/validated_object).

## The Goal: Rich enough vocabulary for Google Schema.org parsing

The plan is to implement a subset of types and attributes relevant to the Google web crawler.
See `test-script.rb` for the supported types. Currently, all the attributes are required.
Propose new types and attributes by opening an Issue.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'schema_dot_org'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install schema_dot_org

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dogweather/schema_dot_org.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
