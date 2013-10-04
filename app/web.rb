module Nana
  class Web < Sinatra::Base
    set :public_folder, File.join(File.dirname(__FILE__), "public")
    set :static, true

    get "/" do
      redirect "/pages"
    end

    get "/pages" do
      @pages = Nana::Page.all.order_by(:path.asc)

      erb :pages
    end

    get "/page/new" do
      @page = Nana::Page.new
      erb :form
    end

    get "/page/:id/edit" do |id|
      @page = Nana::Page.find(id)

      erb :form
    end

    post "/page/:id" do |id|
      @page = Nana::Page.find(id)
      if @page.update_attributes(params)
        redirect "/pages"
      else
        erb :form
      end
    end
  end
end
