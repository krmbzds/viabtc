# ViaBTC 📈

[![Build Status](https://travis-ci.org/krmbzds/viabtc.svg?branch=develop)](https://travis-ci.org/krmbzds/viabtc) [![Downloaded](https://img.shields.io/gem/dt/viabtc.svg)](https://rubygems.org/gems/viabtc) [![Gem Version](https://img.shields.io/gem/v/viabtc.svg)](https://rubygems.org/gems/viabtc) [![RubyDoc](https://img.shields.io/badge/rubydoc-info-blue.svg)](https://www.rubydoc.info/gems/viabtc/)

An HTTP client to interface with the open-source [ViaBTC Exchange Server][ViaBTC Exchange Server Repo].

## Installation

Add `viabtc` to your Gemfile and run `bundle` OR install it yourself with `gem install viabtc`.

## Configuration

If using **Rails**, create a file named `viabtc.rb` under `config/initializers` and add the following block of code.

```rb
ViaBTC.configure do |config|
  config.http_base_url = 'http://localhost:18080'
end
```

If not, add it anywhere in your code that runs before a new client is initialized. Read more at: 📖[Configuration Wiki](https://github.com/krmbzds/viabtc/wiki/Configuration)

## Usage

Create a new instance:

```rb
viabtc_http_client = ViaBTC::HTTP::Client.new
```

Make an API request:

```rb
viabtc_http_client.market_status(market: 'ETHBTC')

#=> {"error"=>nil, "result"=>{"low"=>"0", "period"=>86400, "last"=>"0", "high"=>"0", "open"=>"0", "volume"=>"0", "close"=>"0", "deal"=>"0"}, "id"=>0}
```

## Support

#### Ruby Versions Tested Against

- ✅ `2.6.1` (stable)
- ✅ `2.5.3` (stable)
- ✅ `2.4.5` (stable)
- ⏳ `2.3.8` (security maintenance phase)

#### ViaBTC Exchange Server API Support

- 📖 [HTTP Protocol](https://github.com/krmbzds/viabtc/wiki/API-Support#http-protocol)
- 📖 [WebSocket Protocol](https://github.com/krmbzds/viabtc/wiki/API-Support#websocket-protocol)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [RubyGems][RubyGems].

## Contributing

1. [Fork the repository][Fork]
2. Switch to develop branch (`git checkout develop`)
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request

### Donations ❤️

You can donate me at [Librepay][Donation]. Thanks! ☕️

## Is it any good?

Yes.

## License

Copyright © 2019 [Kerem Bozdas][Personal Webpage]

This gem is available under the terms of the [MIT License][License].

[Donation]: https://liberapay.com/krmbzds/donate
[Fork]: http://github.com/krmbzds/viabtc/fork
[License]: http://kerem.mit-license.org
[Personal Webpage]: http://kerembozdas.com
[RubyGems]: https://rubygems.org
[ViaBTC Exchange Server Repo]: https://github.com/viabtc/viabtc_exchange_server
