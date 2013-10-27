require 'rbconfig'
require File.expand_path('../toki/version', __FILE__)

module Toki

  def when_ruby(options, &block)
    raise ArgumentError, "wrong argument type #{options.class} (expected Hash)" unless options.kind_of?(Hash)
    apply_behaviour(&block) if options.all? do | key, value |
      case key
      when :version
        when_ruby_version(value)
      when :jruby_version
        when_jruby_version(value)
      when :macruby_version
        when_macruby_version(value)
      when :rbx_version
        when_rbx_version(value)
      when :maglev_version
        when_maglev_version(value)
      when :ironruby_version
        when_ironruby_version(value)
      when :kiji_version
        when_kiji_version(value)
      when :engine
        when_ruby_engine(value)
      when :patchlevel
        when_ruby_patchlevel(value)
      when :platform
        when_platform(value)
      else
        raise ArgumentError, "unsupported key #{key} for when_ruby options"
      end
    end
  end

  # JRUBY_VERSION
  def when_jruby_version(value, &block)
    if defined?(JRUBY_VERSION)
      if value_matches_with?(value, JRUBY_VERSION)
        apply_behaviour(&block)
      else
        false
      end
    else
      # JRUBY_VERSION not defined
      false
    end
  end

  # MACRUBY_VERSION
  def when_macruby_version(value, &block)
    if defined?(MACRUBY_VERSION)
      if value_matches_with?(value, MACRUBY_VERSION)
        apply_behaviour(&block)
      else
        false
      end
    else
      # MACRUBY_VERSION not defined
      false
    end
  end

  # Rubinius::VERSION
  def when_rbx_version(value, &block)
    if defined?(Rubinius)
      if value_matches_with?(value, Rubinius::VERSION)
        apply_behaviour(&block)
      else
        false
      end
    else
      # Rubinius not defined
      false
    end
  end

  # MAGLEV_VERSION
  def when_maglev_version(value, &block)
    if defined?(MAGLEV_VERSION)
      if value_matches_with?(value, MAGLEV_VERSION)
        apply_behaviour(&block)
      else
        false
      end
    else
      # MAGLEV_VERSION not defined
      false
    end
  end

  # IRONRUBY_VERSION
  def when_ironruby_version(value, &block)
    if defined?(IRONRUBY_VERSION)
      if value_matches_with?(value, IRONRUBY_VERSION)
        apply_behaviour(&block)
      else
        false
      end
    else
      # IRONRUBY_VERSION not defined
      false
    end
  end

  # KIJI_VERSION
  def when_kiji_version(value, &block)
    if defined?(KIJI_VERSION)
      if value_matches_with?(value, KIJI_VERSION)
        apply_behaviour(&block)
      else
        false
      end
    else
      # KIJI_VERSION not defined
      false
    end
  end

  # RUBY_VERSION
  def when_ruby_version(value, &block)
    if value_matches_with?(value, RUBY_VERSION)
      apply_behaviour(&block)
    else
      false
    end
  end

  # RUBY_PATCHLEVEL
  def when_ruby_patchlevel(value, &block)
    if value_matches_with?(value, RUBY_PATCHLEVEL)
      apply_behaviour(&block)
    else
      false
    end
  end

  # RUBY_ENGINE
  def when_ruby_engine(value, &block)
    # ruby 1.8.7 does not have RUBY_ENGINE constant
    ruby_engine = defined?(RUBY_ENGINE) ? RUBY_ENGINE : 'ruby'
    if value_matches_with?(value, ruby_engine)
      apply_behaviour(&block)
    else
      false
    end
  end

  # RUBY_PLATFORM
  def when_platform(value, &block)
    case value
    when Symbol
      if value == detect_os
        apply_behaviour(&block)
      else
        false
      end
    else
      if value_matches_with?(value, RbConfig::CONFIG['host_os'])
        apply_behaviour(&block)
      else
        false
      end
    end
  end

  private

  def detect_os    
    case RbConfig::CONFIG['host_os']
    when /mswin|msys|mingw|windows|win32|cygwin|bccwin|wince|emc/i
      :windows
    when /darwin|mac os/i
      :osx
    when /linux/i
      :linux
    when /solaris|sunos|bsd/i
      :unix
    else
      :unknown
    end
  end

  def value_matches_with?(value, other)
    case value
    when String, Integer
      value.to_s == other.to_s
    when Regexp
      value =~ other
    when Array
      value.any?{|item| value_matches_with?(item, other)}
    when Symbol
      value == other.to_sym
    else
      raise ArgumentError, "wrong argument type #{value.class} (expected String, Regexp, Array or Symbol)"
    end
  end

  # apply behaviour to target class
  def apply_behaviour(&block)
    if block_given?
      case self
      when Class, Module
        class_eval(&block) 
      else
        instance_eval(&block)
      end
    end
    true
  end

end # Toki