require "spec_helper"
require_relative "../../app/web"

describe Nana::Web do
  include Rack::Test::Methods

  def app
    Nana::Web
  end

  describe "GET /" do
    it "redirects to /pages" do
      get '/'
      expect(last_response).to be_redirect
    end
  end

  describe "GET /pages" do
    it "200" do
      get '/pages'
      expect(last_response).to be_ok
    end
  end

end
