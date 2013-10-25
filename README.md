# with_ruby_version

with_ruby_version is a DSL that helps you to implement Ruby version, patchlevel, engine and platform specific code

## Installation

Add this line to your application's Gemfile:

    gem 'with_ruby_version'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install with_ruby_version

## Usage

```ruby
require 'with_ruby_version'

class Example

  class << self
    def ping
      "pong"
    end
  end

  # ruby 1.8.7 # => "123"
  # ruby 2.0.0 # => "[1,2,3]"
  def array_to_string
    [1,2,3].to_s
  end

  # any mri version of ruby that is 1.9 or later
  with_ruby :version => /^((?!1\.[0-8]).*?)$/, :engine => 'ruby' do

    # also class methods can be defined
    class << self
      def ping
        "PONG"
      end
      # ...
    end

    # applied only if ruby 1.9.x or later
    # ruby 2.0.0 # => "123"
    def array_to_string
      [1,2,3].join
    end

  end

  # applied only if version and patchlevel matches
  with_ruby :version => 'x', :patchlevel => 'xyz' do
    # ...
  end

  # applied only if engine and version matches
  with_ruby :engine => 'jruby', :version => 'x.y.z' do
    # ...
  end

  # applied only if platform matches
  with_ruby :platform => '...' do
    # ...
  end

  # alternative method to specify ruby version specific implementation
  with_ruby_version 'x.y.z' do 
    # ...
  end

  with_ruby_patchlevel 'zyx' do 
    # ...
  end

  with_ruby_engine 'engine_xyz' do
    # ...
  end

  with_ruby_platform 'platform-i386' do
    # ...
  end

end

# 1.8.7
puts Example.ping # => 'pong'

# 1.8.7
puts Example.new.array_to_string # => "123"

# 2.0.0
puts Example.ping # => 'PONG'

# 2.0.0
puts Example.new.array_to_string # => "123"
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
