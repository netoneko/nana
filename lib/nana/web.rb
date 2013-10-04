module Nana
  class Web < Sinatra::Base
    get '/' do
      "Hello World"
    end
  end
end
