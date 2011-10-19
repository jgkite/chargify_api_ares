$LOAD_PATH.unshift File.expand_path('../lib', File.dirname(__FILE__))
require 'rspec'
require 'chargify_api_ares'
require 'fakeweb'
require 'mocks/fake_resource'
require 'factory_girl'
require 'faker'
require 'factories'

ActiveResource::Base.send :include, ActiveResource::FakeResource

Chargify.configure do |c|
  c.subdomain = 'test'
  c.api_key   = 'test'
end
 
RSpec.configure do |config|
  config.before do
    FakeWeb.allow_net_connect = false
  end
  
  config.after(:each) do
    ActiveResource::FakeResource.clean
  end
end

def test_domain
  "#{Chargify::Base.connection.site.scheme}://#{Chargify::Base.connection.user}:#{Chargify::Base.connection.password}@#{Chargify::Base.connection.site.host}:#{Chargify::Base.connection.site.port}"
end
