# TouRETS

The name came from a play on Tourette's and RETS. Because when you work with RETS you feel like you have Tourette's. This gem is to interface this ugly thing with rails in a easy and soothing manner.

## Installation

Add this line to your application's Gemfile:

    gem 'tourets'

Add a rets_config.yml to your config directory

	-
	  mls: 'GLVAR'
	  url: 'http://las.rets.interealty.com/Login.asmx/Login'
	  username: 'user'
	  password: 'secret'
	  rets_version: '1.8'
	  auth_mode: :digest
	  useragent:
	    name: 'some_user_connector'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tourets

## Usage
(since this is still new, this usage may change often)

```ruby
TouRETS.establish_connection('GLVAR')
@properties = TouRETS::Property.where(:bedrooms => 3, :bathrooms => 2)
TouRETS.close_connection
```



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
