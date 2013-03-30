require 'pathname'
require 'test/unit'

$:.unshift File.expand_path('../../lib', __FILE__)

class RelatedTestCase < Test::Unit::TestCase
  class FakeVim
    attr_reader :messages, :commands

    def message(msg)
      @messages ||= []
      @messages << msg
    end

    def command(cmd)
      @commands ||= []
      @commands << cmd
    end
  end

  class FakeRelated
    attr_accessor :repo_root, :current_file_relative_to_repo

    def initialize
      @repo_root, @current_file_relative_to_repo = Pathname.new("/path_to_repo/"), Pathname.new("")
    end
  end

  def self.test(name, &block)
    raise ArgumentError, "Example name can't be blank" if String(name).empty?
    raise ArgumentError, "Example not provided" if block.nil?
    define_method("test #{name}", &block)
  end

  private

  def default_test
    # Make Test::Unit happy...
  end

  def fake_vim
    @fake_vim ||= FakeVim.new
  end

  def fake_related
    @fake_related ||= FakeRelated.new
  end

  def pathname(path)
    Pathname.new(path)
  end
end

