require 'bundler'
Bundler.require(:default, :development)

SPEC_ROOT = File.expand_path File.dirname(__FILE__)
Dir["#{SPEC_ROOT}/support/**/*.rb"].each { |f| require f unless File.basename(f) =~ /^_/ }

NoBrainer.configure do |config|
  config.app_name = :no_brainer_soft_delete
  config.environment = :test
end

RSpec.configure do |config|
  config.color = true
  config.expect_with :rspec do |c|
    c.syntax = [:expect]
  end

  NoBrainer.sync_indexes

  config.before(:each) do
    NoBrainer.purge!
  end
end
