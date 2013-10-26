require 'test/unit'
require File.expand_path('../../lib/toki', __FILE__)

class TestToki < Test::Unit::TestCase

  def setup
    # do nothing
  end

  def teardown
    # do nothing
  end

  def test_ruby_version
    klass = Class.new do
      extend Toki
      def hello
        nil
      end
      when_ruby :version => RUBY_VERSION do
        def hello
          "world"
        end
      end
    end
    instance = klass.new
    assert_equal "world", instance.hello
  end

  def test_jruby_version
    unless (jruby_version_defined = defined?(JRUBY_VERSION))
      Object.const_set(:JRUBY_VERSION, '1.7.4')
    end
    klass = Class.new do
      extend Toki
      def hello
        nil
      end
      when_ruby :jruby_version => '1.7.4' do
        def hello
          "world"
        end
      end
    end
    instance = klass.new
    assert_equal "world", instance.hello
  ensure
    Object.send(:remove_const, :JRUBY_VERSION) unless jruby_version_defined
  end

  def test_rbx_version
    unless (rbx_defined = defined?(Rubinius))
      klass = Class.new
      klass.const_set(:VERSION, '2.1.1')
      Object.const_set(:Rubinius, klass)
    end
    klass = Class.new do
      extend Toki
      def hello
        nil
      end
      when_ruby :rbx_version => '2.1.1' do
        def hello
          "world"
        end
      end
    end
    instance = klass.new
    assert_equal "world", instance.hello
  ensure
    Object.send(:remove_const, :Rubinius) unless rbx_defined
  end

  def test_macruby_version
    unless (macruby_version_defined = defined?(MACRUBY_VERSION))
      Object.const_set(:MACRUBY_VERSION, '0.12')
    end
    klass = Class.new do
      extend Toki
      def hello
        nil
      end
      when_ruby :macruby_version => '0.12' do
        def hello
          "world"
        end
      end
    end
    instance = klass.new
    assert_equal "world", instance.hello
  ensure
    Object.send(:remove_const, :MACRUBY_VERSION) unless macruby_version_defined
  end

  def test_ruby_patchlevel
    klass = Class.new do
      extend Toki
      def hello
        nil
      end
      when_ruby :patchlevel => RUBY_PATCHLEVEL do
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
      extend Toki
      def hello
        nil
      end
      when_ruby :engine => ruby_engine do
        def hello
          "world"
        end
      end
    end
    instance = klass.new
    assert_equal "world", instance.hello
  end

  def test_platform
    klass = Class.new do
      extend Toki
      def hello
        nil
      end
      when_ruby :platform => RbConfig::CONFIG['host_os'] do
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
      extend Toki
      def self.hello
        nil
      end
      when_ruby :version => Regexp.union(RUBY_VERSION) do
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