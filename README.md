[![Gem Version](https://badge.fury.io/rb/schema_dot_org.svg)](https://badge.fury.io/rb/schema_dot_org) [![Maintainability](https://api.codeclimate.com/v1/badges/e0c60b4cbc998563a484/maintainability)](https://codeclimate.com/github/dogweather/schema-dot-org/maintainability)

# SchemaDotOrg

Let's create [Structured Data](https://developers.google.com/search/docs/guides/intro-structured-data) with correct **syntax** and **semantics**,
every single time. Good structured data [helps enhance a website's search result appearance](https://developers.google.com/search/docs/guides/enhance-site).

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
  logo:             'https://www.public.law/favicon-196x196.png',
  same_as: [
    'https://twitter.com/law_is_code',
    'https://www.facebook.com/PublicDotLaw'
    ]
  )
```

...and this in a template:

```html
<%= @public_law %>
```

...you'll get this in the HTML:

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
  },
  "sameAs": [
    "https://twitter.com/law_is_code",
    "https://www.facebook.com/PublicDotLaw"
  ]
}
</script>
```

Strong typing is at work here. `SchemaDotOrg` will validate your code, and if correct, will generate Schema.org JSON-LD markup. If not, you'll get a descriptive error message.

 Notice how the `foundingDate` is in the required ISO-8601 format. [The founding date must be a Ruby
Date object](https://github.com/dogweather/schema-dot-org/blob/master/lib/schema_dot_org/organization.rb#L11) and so we can ensure correct formatting. In the same way, the `foundingLocation` is a `Place`
which adds the proper `@type` attribute.

### You are prevented from creating invalid markup

If you use the wrong type or try to set an unknown attribute, SchemaDotOrg will
refuse to create the incorrect JSON-LD. Instead, you'll get a message explaining
the problem:

```ruby
Place.new(address: 12345)
# => ArgumentError: Address is class Integer, not String

Place.new(
  address: '12345 Happy Street',
  author:  'Hemmingway'
)
# => NoMethodError: undefined method `author'
```

This type safety comes from the [ValidatedObject gem](https://github.com/dogweather/validated_object).

## Supported Schema.org Types

### WebSite

Example with only the required attributes:

```ruby
WebSite.new(
  name: 'Texas Public Law',
  url:  'https://texas.public.law',
)
```

With the optional `SearchAction` to enable a [Sitelinks Searchbox](https://developers.google.com/search/docs/data-types/sitelinks-searchbox):

```ruby
WebSite.new(
  name: 'Texas Public Law',
  url:  'https://texas.public.law',
  potential_action: SearchAction.new(
    target: 'https://texas.public.law/?search={search_term_string}',
    query_input: 'required name=search_term_string'
  )
)
```

### Organization

Example:

```ruby
Organization.new(
  name:             'Public.Law',
  founder:           Person.new(name: 'Robb Shecter'),
  founding_date:     Date.new(2009, 3, 6),
  founding_location: Place.new(address: 'Portland, OR'),
  email:            'say_hi@public.law',
  url:              'https://www.public.law',
  logo:             'https://www.public.law/favicon-196x196.png',
  same_as: [
    'https://twitter.com/law_is_code',
    'https://www.facebook.com/PublicDotLaw'
  ]
)
```

### Person, Place, and SearchAction

These three aren't too useful on their own in web apps. They're used when creating a `WebSite` and `Organization`, as shown above.

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

Bug reports and pull requests are welcome on GitHub at https://github.com/public-law/schema-dot-org.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
