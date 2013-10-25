require 'test/unit'
require File.expand_path('../../lib/with_ruby_version', __FILE__)

class TestWithRubyVersion < Test::Unit::TestCase

  def setup
    # do nothing
  end

  def teardown
    # do nothing
  end

  def test_ruby_version
    klass = Class.new do
      def hello
        nil
      end
      with_ruby :version => RUBY_VERSION do
        def hello
          "world"
        end
      end
    end
    instance = klass.new
    assert_equal "world", instance.hello
  end

  def test_ruby_patchlevel
    klass = Class.new do
      def hello
        nil
      end
      with_ruby :patchlevel => RUBY_PATCHLEVEL do
        def hello
          "world"
        end
      end
    end
    instance = klass.new
    assert_equal "world", instance.hello
  end

  def test_ruby_engine
    ruby_engine = defined?(RUBY_ENGINE) ? RUBY_ENGINE : 'ruby'
    klass = Class.new do
      def hello
        nil
      end
      with_ruby :engine => ruby_engine do
        def hello
          "world"
        end
      end
    end
    instance = klass.new
    assert_equal "world", instance.hello
  end

  def test_ruby_platform
    klass = Class.new do
      def hello
        nil
      end
      with_ruby :platform => RUBY_PLATFORM do
        def hello
          "world"
        end
      end
    end
    instance = klass.new
    assert_equal "world", instance.hello
  end

  def test_class_methods
    klass = Class.new do
      def self.hello
        nil
      end
      with_ruby :version => Regexp.union(RUBY_VERSION) do
        class << self
          def hello
            "world"
          end
        end
      end
    end
    assert_equal "world", klass.hello
  end

end