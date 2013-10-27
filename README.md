# Toki [![Gem Version](https://badge.fury.io/rb/toki.png)](http://badge.fury.io/rb/toki)

Toki is a DSL that helps you to implement Ruby version, patchlevel, engine and platform specific code

## Installation

Add this line to your application's Gemfile:

    gem 'toki'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install toki

## Usage

```ruby
require 'toki'

class Example
  extend Toki

  def self.ping
    "pong"
  end

  # ruby 1.8.7 # => "123"
  # ruby 2.0.0 # => "[1,2,3]"
  def array_to_string
    [1,2,3].to_s
  end

  # any mri version of ruby that is 1.9 or later
  when_ruby :engine => 'ruby', :version => /^((?!1\.[0-8]).*?)$/ do
    # also class methods can be defined
    def self.ping
      "gnop"
    end
    # applied only if ruby 1.9.x or later; overwrites array_to_string method
    # ruby 2.0.0 # => "123"
    def array_to_string
      [1,2,3].join
    end
  end

  # applied only if version and patchlevel matches
  when_ruby :version => '1.8.7',    :patchlevel       => '371'    do; end

  # applied only if engine and version matches
  when_ruby :engine  => 'ruby',     :version          => '1.8.7'  do; end
  when_ruby :engine  => 'jruby',    :jruby_version    => '1.7.6'  do; end
  when_ruby :engine  => 'macruby',  :macruby_version  => '0.12'   do; end
  when_ruby :engine  => 'rbx',      :rbx_version      => '2.1.1'  do; end
  when_ruby :engine  => 'maglev',   :maglev_version   => '1.1RC1' do; end
  when_ruby :engine  => 'ironruby', :ironruby_version => '1.1.3'  do; end
  when_ruby :engine  => 'kiji',     :kiji_version     => '0.11'   do; end

  # applied only if platform matches; :windows, :osx, :linux, :unix, :unknown
  when_ruby :platform => :linux         do; end
  when_ruby :platform => /linux/        do; end

  # alternative method to specify ruby version specific implementation
  when_ruby_version     '2.0.0'         do; end
  when_jruby_version    '1.7.6'         do; end
  when_macruby_version  '0.12'          do; end
  when_rbx_version      '2.1.1'         do; end
  when_maglev_version   '1.1RC1'        do; end
  when_ironruby_version '1.1.3'         do; end
  when_kiji_version     '0.11'          do; end
  when_ruby_patchlevel  '371'           do; end
  when_ruby_engine      'rbx'           do; end
  when_platform         :osx            do; end

end

# MRI 1.8.7
puts Example.ping                 # => "pong"
puts Example.new.array_to_string  # => "123"

# MRI 2.0.0
puts Example.ping                 # => "gnop"
puts Example.new.array_to_string  # => "123"
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Copyright (c) 2013 Jussi Koljonen

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.