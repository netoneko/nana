module Nana
  class Web < Sinatra::Base
    set :public_folder, File.join(File.dirname(__FILE__), "public")
    set :static, true

    get '/' do
      @page = Nana::Page.last

      erb :form
    end
  end
end
