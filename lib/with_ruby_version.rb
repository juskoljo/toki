require File.expand_path('../with_ruby_version/version', __FILE__)

module WithRubyVersion

  def with_ruby(options, &block)
    raise ArgumentError, "wrong argument type #{options.class} (expected Hash)" unless options.kind_of?(Hash)
    apply_behaviour(&block) if options.all? do | key, value |
      case key
      when :version
        with_ruby_version(value)
      when :engine
        with_ruby_engine(value)
      when :patchlevel
        with_ruby_patchlevel(value)
      when :platform
        with_ruby_platform(value)
      else
        raise ArgumentError, "unsupported key #{key} for with_ruby options"
      end
    end
  end

  # RUBY_VERSION
  def with_ruby_version(pattern, &block)
    if pattern_matches_with?("#{RUBY_VERSION}p#{RUBY_PATCHLEVEL}", pattern)
      apply_behaviour(&block)
    else
      false
    end
  end

  # RUBY_PATCHLEVEL
  def with_ruby_patchlevel(pattern, &block)
    if pattern_matches_with?(RUBY_PATCHLEVEL, pattern)
      apply_behaviour(&block)
    else
      false
    end
  end

  # RUBY_ENGINE
  def with_ruby_engine(pattern, &block)
    # ruby 1.8.7 does not have RUBY_ENGINE constant
    ruby_engine = defined?(RUBY_ENGINE) ? RUBY_ENGINE : 'ruby'
    if pattern_matches_with?(ruby_engine, pattern)
      apply_behaviour(&block)
    else
      false
    end
  end

  # RUBY_PLATFORM
  def with_ruby_platform(pattern, &block)
    if pattern_matches_with?(RUBY_PLATFORM, pattern)
      apply_behaviour(&block)
    else
      false
    end
  end

  private

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

end

# apply with WithRubyVersion to Module
class Module
  include WithRubyVersion
end

# apply with WithRubyVersion to Class
class Class
  include WithRubyVersion
end
