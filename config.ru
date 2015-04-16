require 'rubygems'
require 'sinatra'
require 'json'
require 'rack/recaptcha'
require 'pony'

use Rack::Recaptcha, :public_key => '6LeObAUTAAAAAMtfwY22umX9YCTNoklUHp1wBj2I', :private_key => '6LeObAUTAAAAAAWfcpqxIaqVNvV8WRQ7yYyFvJgC'
helpers Rack::Recaptcha::Helpers

require './application'
run Sinatra::Application