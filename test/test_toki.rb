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
    if (jruby_version_defined = defined?(JRUBY_VERSION))
      version = JRUBY_VERSION
    else
      Object.const_set(:JRUBY_VERSION, (version = 'x.x.x'))
    end
    klass = Class.new do
      extend Toki
      def hello
        nil
      end
      when_ruby :jruby_version => version do
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
    if (rbx_defined = defined?(Rubinius))
      version = Rubinius::VERSION
    else
      klass = Class.new
      klass.const_set(:VERSION, (version = 'x.x.x'))
      Object.const_set(:Rubinius, klass)
    end
    klass = Class.new do
      extend Toki
      def hello
        nil
      end
      when_ruby :rbx_version => version do
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
    if (macruby_version_defined = defined?(MACRUBY_VERSION))
      version = MACRUBY_VERSION
    else
      Object.const_set(:MACRUBY_VERSION, (version = 'x.x.x'))
    end
    klass = Class.new do
      extend Toki
      def hello
        nil
      end
      when_ruby :macruby_version => version do
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

  def test_maglev_version
    if (maglev_version_defined = defined?(MAGLEV_VERSION))
      version = MAGLEV_VERSION
    else
      Object.const_set(:MAGLEV_VERSION, (version = 'x.x.x'))
    end
    klass = Class.new do
      extend Toki
      def hello
        nil
      end
      when_ruby :maglev_version => version do
        def hello
          "world"
        end
      end
    end
    instance = klass.new
    assert_equal "world", instance.hello
  ensure
    Object.send(:remove_const, :MAGLEV_VERSION) unless maglev_version_defined
  end

  def test_ironruby_version
    if (ironruby_version_defined = defined?(IRONRUBY_VERSION))
      version = IRONRUBY_VERSION
    else
      Object.const_set(:IRONRUBY_VERSION, (version = 'x.x.x'))
    end
    klass = Class.new do
      extend Toki
      def hello
        nil
      end
      when_ruby :ironruby_version => version do
        def hello
          "world"
        end
      end
    end
    instance = klass.new
    assert_equal "world", instance.hello
  ensure
    Object.send(:remove_const, :IRONRUBY_VERSION) unless ironruby_version_defined
  end

  def test_kiji_version
    if (kiji_version_defined = defined?(KIJI_VERSION))
      version = KIJI_VERSION
    else
      Object.const_set(:KIJI_VERSION, (version = 'x.x.x'))
    end
    klass = Class.new do
      extend Toki
      def hello
        nil
      end
      when_ruby :kiji_version => version do
        def hello
          "world"
        end
      end
    end
    instance = klass.new
    assert_equal "world", instance.hello
  ensure
    Object.send(:remove_const, :KIJI_VERSION) unless kiji_version_defined
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