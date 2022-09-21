require_relative '../coverage_helper'
ENV["RACK_ENV"] = "test"
require_relative '../../app'
raise "test database doesn't end with test" if DB.opts[:database] && !DB.opts[:database].end_with?('test')

require 'rack/test'
Gem.suffix_pattern

require_relative '../minitest_helper'

begin
  require 'refrigerator'
rescue LoadError
else
  Refrigerator.freeze_core
end

PatchApp.plugin :not_found do
  raise "404 - File Not Found"
end
PatchApp.plugin :error_handler do |e|
  raise e
end

class Minitest::HooksSpec
  include Rack::Test::Methods

  def app
    PatchApp.app
  end
end
