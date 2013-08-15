require 'rubygems'
require 'bundler/setup'

if ENV["TRAVIS"]
  require 'coveralls'
  Coveralls.wear!
end

require 'test/unit'
require 'pathname'

$:.unshift File.expand_path('../../lib', __FILE__)

class RelatedTestCase < Test::Unit::TestCase
  class FakeVim
    attr_reader :messages, :commands, :evaluations

    def initialize
      @evaluations = {}
    end

    def message(msg)
      @messages ||= []
      @messages << msg
    end

    def command(cmd)
      @commands ||= []
      @commands << cmd
    end

    def evaluate(expr, options = {})
      if options.key?(:to)
        @evaluations[expr] = options[:to]
      else
        @evaluations.fetch(expr) { raise ArgumentError, "VIM had to evaluate unexpected expression: #{expr}" }
      end
    end
  end

  class FakeRelatedPaths
    attr_accessor :repo_root, :current_file_relative_to_repo

    def initialize
      @repo_root, @current_file_relative_to_repo = Pathname.new("/path_to_repo/"), Pathname.new("")
    end
  end

  def self.test(name, &block)
    raise ArgumentError, "Example name can't be blank" if String(name).empty?
    block ? define_method("test #{name}", &block) : xtest(name)
  end

  def self.xtest(name)
    define_method("test #{name}", proc { warn "#{name}: pending" })
  end

  private

  def default_test
    # Make Test::Unit happy...
  end

  def fake_vim
    @fake_vim ||= FakeVim.new
  end

  def fake_related_paths
    @fake_related_paths ||= FakeRelatedPaths.new
  end

  def pathname(path)
    Pathname.new(path)
  end
end

