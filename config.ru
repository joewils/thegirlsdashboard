$: << File.expand_path('./lib', File.dirname(__FILE__))
require 'dashing-contrib'
require 'dashing'
DashingContrib.configure

require 'yaml'
require 'httparty'
require 'nokogiri'

require_relative 'girls'

configure do
  set :auth_token, 'All things truly wicked start from innocence.'

  helpers do
    def protected!
     # Put any authentication code you want in here.
     # This method is run before accessing any resource.
    end
  end
end

map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

run Sinatra::Application