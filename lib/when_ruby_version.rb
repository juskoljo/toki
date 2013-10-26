require 'rbconfig'
require File.expand_path('../when_ruby_version/version', __FILE__)

module WhenRubyVersion

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
  def when_jruby_version(pattern, &block)
    if defined?(JRUBY_VERSION)
      if pattern_matches_with?(JRUBY_VERSION, pattern)
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
  def when_macruby_version(pattern, &block)
    if defined?(MACRUBY_VERSION)
      if pattern_matches_with?(MACRUBY_VERSION, pattern)
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
  def when_rbx_version(pattern, &block)
    if defined?(Rubinius)
      if pattern_matches_with?(Rubinius::VERSION, pattern)
        apply_behaviour(&block)
      else
        false
      end
    else
      # Rubinius not defined
      false
    end
  end

  # RUBY_VERSION
  def when_ruby_version(pattern, &block)
    if pattern_matches_with?(RUBY_VERSION, pattern)
      apply_behaviour(&block)
    else
      false
    end
  end

  # RUBY_PATCHLEVEL
  def when_ruby_patchlevel(pattern, &block)
    if pattern_matches_with?(RUBY_PATCHLEVEL, pattern)
      apply_behaviour(&block)
    else
      false
    end
  end

  # RUBY_ENGINE
  def when_ruby_engine(pattern, &block)
    # ruby 1.8.7 does not have RUBY_ENGINE constant
    ruby_engine = defined?(RUBY_ENGINE) ? RUBY_ENGINE : 'ruby'
    if pattern_matches_with?(ruby_engine, pattern)
      apply_behaviour(&block)
    else
      false
    end
  end

  # RUBY_PLATFORM
  def when_platform(pattern, &block)
    case pattern
    when Symbol
      if pattern == detect_os
        apply_behaviour(&block)
      else
        false
      end
    else
      if pattern_matches_with?(RbConfig::CONFIG['host_os'], pattern)
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

  def pattern_matches_with?(constant, pattern)
    constant.to_s =~ case pattern
    when String, Integer
      Regexp.union(pattern.to_s)
    when Regexp
      pattern
    else
      raise ArgumentError, "wrong argument type #{pattern.class} (expected String or Regexp)"
    end
  end

  # apply behaviour to target class
  def apply_behaviour(&block)
    class_eval(&block) if block_given?
    true
  end

end # WhenRubyVersion