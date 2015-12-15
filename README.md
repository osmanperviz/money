# Money

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/money`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'money',:git =>'git://github.com/osmanperviz/money.git'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install money


## Development
The development version  can be installed with:
```ruby
git clone git://github.com/RubyMoney/money.git
cd money
rake install
 ```

## Usage
```ruby
fifty_eur = Money.new(50, "EUR")
fifty_eur.amaount    #=> 50
fifty_eur.currency  #=> "USD"
fifty_eur.inspect #=> "50 EUR"

fifty_eur.convert_to('USD') # => 55.50 USD

#Operations in different currencies
twenty_dollars = Money.new(20, 'USD')

# Arithmetics:
fifty_eur + twenty_dollars # => 68.02 EUR
fifty_eur - twenty_dollars # => 31.98 EUR
fifty_eur / 2              # => 25 EUR
twenty_dollars * 3         # => 60 USD

# Comparisons (also in different currencies):

twenty_dollars == Money.new(20, 'USD') # => true
twenty_dollars == Money.new(30, 'USD') # => false

fifty_eur_in_usd = fifty_eur.convert_to('USD')
fifty_eur_in_usd == fifty_eur          # => true

twenty_dollars > Money.new(5, 'USD')   # => true
twenty_dollars < fifty_eur             # => true

```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/money. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

