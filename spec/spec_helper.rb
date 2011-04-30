require 'active_support'
require 'active_support/deprecation'
require 'action_view'
require 'rspec/rails/adapters'
require 'rspec/rails/example/rails_example_group'
require 'rspec/rails/matchers/render_template'
require 'rspec/rails/browser_simulators'
require 'rspec/rails/example/view_example_group'
require 'rspec/rails/mocks'
require 'webrat'
require "webrat/integrations/rspec-rails"
require 'webrat/core/matchers'

plugin_spec_dir = File.dirname(__FILE__)
#ActiveRecord::Base.logger = Logger.new(plugin_spec_dir + "/debug.log")

RSpec::configure do |c|
  c.include RSpec::Rails::ViewExampleGroup, :type => :view, :example_group => {
    :file_path => 'spec/views'
  }
end

