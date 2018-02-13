[![CircleCI](https://circleci.com/gh/dogweather/schema-dot-org.svg?style=svg)](https://circleci.com/gh/dogweather/schema-dot-org) [![Gem Version](https://badge.fury.io/rb/schema_dot_org.svg)](https://badge.fury.io/rb/schema_dot_org) [![Maintainability](https://api.codeclimate.com/v1/badges/e0c60b4cbc998563a484/maintainability)](https://codeclimate.com/github/dogweather/schema-dot-org/maintainability)

# SchemaDotOrg

Let's create [Structured Data](https://developers.google.com/search/docs/guides/intro-structured-data) that's correct,
every single time.

> Google Search works hard to understand the content of a page. You can help us by providing explicit clues about the meaning of a page . . .

## Usage

Create the tree of objects, and then call `#to_s` in e.g., a Rails template:

```ruby
require 'schema_dot_org/place'
require 'schema_dot_org/organization'
include SchemaDotOrg


@public_law = Organization.new do |org|
  org.name  = "Public.Law"
  org.email = "say_hi@public.law"
  org.url   = "https://www.public.law"
  org.founding_location = Place.new do |place|
    place.address = "Portland, OR"
  end
end
```

```html
<%= @public_law %>
```

The generated webpage will contain correct Schema.org JSON-LD markup:

```html
<script type="application/ld+json">
{
  "@context": "http://schema.org",
  "@type": "Organization",
  "name": "Public.Law",
  "email": "say_hi@public.law",
  "url": "https://www.public.law",
  "foundingLocation": {
    "@type": "Place",
    "address": "Portland, OR"
  }
```

### You cannot create invalid markup 

E.g., If you use the wrong type or try to set an unknown attribute, SchemaDotOrg will
refuse to create the incorrect JSON-LD. Instead, you'll get a message explaining
the problem:

```ruby
Place.new { |p| p.address = 12345 }
# => ArgumentError: Address is class Integer, not String

Place.new do |p|
  p.address = '12345 Happy Street'
  p.author  = 'Hemmingway'
end
# => NoMethodError: undefined method `author='
```

This type safety comes from the [ValidatedObject gem](https://github.com/dogweather/validated_object).

## The Goal: Rich enough vocabulary for Google Schema.org parsing

The end result is to output website metadata like this (taken from my site [public.law](https://www.public.law)):

```html
<script type="application/ld+json">
  {
  "@context": "http://schema.org",
  "@type": "Organization",
  "email": "sayhi@public.law",
  "founder": {
    "@type": "Person",
    "name": "Robb Shecter"
    },
  "foundingDate": "2009-03-06",
  "foundingLocation": {
    "@type": "Place",
    "address": "Portland, Oregon"
  },
  "logo": "https://www.public.law/favicon-196x196.png",
  "name": "Public.Law",
  "sameAs": [
    "https://twitter.com/law_is_code",
    "https://www.facebook.com/PublicDotLaw",
    "https://www.linkedin.com/company/9170633/"
  ],
  "url": "https://www.public.law"
  }
</script>
```

And it should do it in a **typesafe** way. That is, not merely syntactically correct,
but also _semantically_ correct. It should, e.g.,  ensure that only allowed
attributes are used.

## Schema Development Roadmap

| Type | Planned | Completed |
| ---- |:-------:|:---------:|
| Place | X | X |
| Person | X |
| Organization | X |
| Date | X |
| URL | X |

The plan is to implement a small subset of types and attributes relevant to the Google web crawler.
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
