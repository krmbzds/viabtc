# ViaBTC

An HTTP client to interface with the open-source [ViaBTC Exchange Server][ViaBTC Exchange Server Repo] API.

## Installation

Add `viabtc` to your Gemfile and run `bundle` OR install it yourself with `gem install viabtc`.

## Configuration

If using **Rails**, create a file named `viabtc.rb` under `config/initializers` and add the following block of code.

```rb
ViaBTC.configure do |config|
  config.base_url = 'http://localhost:18080'
  config.faraday_response = :logger
  config.faraday_adapter = :net_http
end
```

If not, add it anywhere in your code that runs before a new client is initialized.

## Usage

Create a new instance:

```rb
viabtc_client = ViaBTC::Client.new
```

Make an API request:

```rb
viabtc_client.market_status(market: 'ETHBTC')
```

Market status example output:
```rb
{"error"=>nil, "result"=>{"low"=>"0", "period"=>86400, "last"=>"0", "high"=>"0", "open"=>"0", "volume"=>"0", "close"=>"0", "deal"=>"0"}, "id"=>0}
```

## Support

### API Actions

#### HTTP Protocol

| API Method | Corresponding Methods |
|---|---|
| `balance.query` | `#balance` |
| `balance.update` | `#withdraw` `#deposit` |
| `balance.history` | `#balance_history`  |
| `asset.list` | `#asset_list` |
| `asset.summary` | `#asset_summary` |
| `order.put_limit` | `#limit_sell` `#limit_buy` |
| `order.put_market` | `#market_sell` `#market_buy` |
| `order.cancel` | `#cancel_order` |
| `order.deals` | `#order_deals` |
| `order.book` | `#sell_orders` `#buy_orders` |
| `order.depth` | `#order_depth` |
| `order.pending` | `#pending_orders` |
| `order.pending_detail` | `#pending_order_details` |
| `order.finished` | `#finished_orders` `#finished_sell_orders` `#finished_buy_orders` |
| `order.finished_detail` | `#finished_order_detail` |
| `market.last` | `#market_last` |
| `market.deals` | `#market_deals` |
| `market.user_deals` | `#user_executed_orders` |
| `market.kline` | `#market_kline` |
| `market.status` | `#market_status` |
| `market.status_today` | `#market_status_today` |
| `market.list` | `#market_list` |
| `market.summary` | `#market_summary` |

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

### Donations

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
