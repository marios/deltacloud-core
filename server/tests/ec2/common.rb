require 'rubygems'
require 'require_relative' if RUBY_VERSION < '1.9'
require 'minitest/autorun'

require_relative File.join('..', '..', 'lib', 'deltacloud_rack.rb')
require_relative '../test_helper.rb'

# Setup Deltacloud::API Sinatra instance
#

Deltacloud::configure(:ec2) do |server|
  server.root_url '/ec2'
  server.version '2012-04-01'
  server.klass 'Deltacloud::EC2::API'
  server.logger Rack::DeltacloudLogger.setup(ENV['API_LOG'], ENV['API_VERBOSE'])
  server.default_driver :mock
end

Deltacloud[:ec2].require!
Deltacloud[:ec2].default_frontend!

# The root_url here is '/' because the application is not
# mounted and so by default Sinatra mounts it on '/'

def root_url; '/'; end
