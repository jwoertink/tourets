# TouRETS

The name came from a play on Tourette's and RETS. Because when you work with RETS you feel like you have Tourette's.
The goal of this gem is to make a really clean and familiar API for connecting to a RETS server. This gem was designed to be used with rails, so it takes a lot of the API that rails uses.

## Installation

Add this line to your application's Gemfile:

    gem 'tourets', github: 'jwoertink/tourets'

Add a rets_config.yml to the config directory of your rails app

```yaml
-
  mls: 'GLVAR'
  url: 'http://las.rets.interealty.com/Login.asmx/Login'
  username: 'user'
  password: 'secret'
  rets_version: '1.8'
  auth_mode: :digest
  useragent:
    name: 'some_user_connector'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tourets

## Usage
(since this is still new, this usage may change often)

```ruby
begin
	TouRETS.establish_connection('GLVAR')
	# Get a list of properties with 3 bedrooms and 2 bathrooms
	@properties = TouRETS::Property.where(:bedrooms => 3, :bathrooms => 2)
	# Grab all the photos for the first property
	@photos = @properties.first.photos
	# Iterate through all those photos, save them into tempfiles, and then do stuff?
	@photos.each do |photo|
		begin
			tmp = Tempfile.new(photo.filename)
			tmp.write(photo.image)
			# you have an actual photo now. Maybe push to S3?
		ensure
			tmp.close
			tmp.unlink
		end
	end
ensure
	TouRETS.close_connection
end
```

Before doing anything, you must make your first initial connection to your MLS server.
```ruby
if TouRETS.current_connection?
	# Get the sysid for the last property in that instance array
	property_id = @properties.last.id
	puts property_id 					#=> 1234567
	# Grab the second picture for that property
	picture = TouRETS::Photo.find(property_id, :id => 2)
	puts picture.content_type	#=> image/jpeg
	puts picture.filename 		#=> 1234567-2.jpg
	puts picture.id 					#=> 2
	# This returns the binary string data that gets written to a file
	puts picture.image.class	#=> String
end
```

## ruby-rets
This gem relies heavily on the work done by Zachary Anker (zanker) with the [ruby-rets](https://github.com/Placester/ruby-rets) gem.
There is a `TouRETS::Search#find` class which just makes a direct call to the `RETS::Base::Core#search`. This gives you the option to still use
that gem inside of this one.

## TODO (in no particular order)
1. Add in other Objects like VRImage, Thumbnail, Map, Video, Audio
2. Add in other Resources like Agent, Office, LotsAndLand
3. CLEAN CODE!!!!!
4. Add in limits, and selects to searches
5. TEST TEST TEST TEST
6. Add some passing specs.
7. Document the hell out of this thing


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
