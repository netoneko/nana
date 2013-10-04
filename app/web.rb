module Nana
  class Web < Sinatra::Base
    set :public_folder, File.join(File.dirname(__FILE__), "public")
    set :static, true

    get '/' do
      @page = Nana::Page.last

      erb :form
    end

    post '/update' do
      Nana::Page.find(params[:id]).update_attributes(params)
      redirect '/'
    end
  end
end
