require 'spec_helper'
require 'rack/test'
require 'rspec'
require 'rspec-expectations'
require 'dev_challenge'


describe DevChallenge do
  # describe 'creating the database' do
  # end

  # describe 'showing records' do
  # end
  
  # describe 'showing records sorted by two criteria' do
  # end
  
  # describe 'adding a line to the database' do
  # end
  
end


describe API do
  include Rack::Test::Methods
  describe "getting records with field passed via param" do
    it "returns a json object" do
      get '/records/dob'
      response.header['Content-Type'].should include 'application/json'
    end
  end

  # describe 'getting records via params sorted by two criteria' do
  # end
  
  # describe 'posting new line to the database' do
  # end

end
