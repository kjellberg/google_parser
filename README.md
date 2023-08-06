Google Parser
=============
Google Parser is a ruby library that extracts keyword rankings from a Google SERP html page.

## Example
```ruby
html = reponse.body # Custom scraping logic

google_parser = GoogleParser::GoogleParser.new(html)
google_parser.organic_results
```

## Installation

Add the following to your `Gemfile`:

```ruby
gem "google_parser", "~> 0.1.0"
```

or run `gem install google_parser` to install it globally.
