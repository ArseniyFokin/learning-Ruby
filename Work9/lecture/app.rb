# frozen_string_literal: true

require 'roda'

class App < Roda
  route do |r|
    # GET / request
    r.root do # Корневой запрос
      r.redirect '/hello' # Переадресация
    end

    # /hello branch
    r.on 'hello' do
      # Set variable for all routes in /hello branch
      @greeting = 'Hello with rerun'

      # GET /hello/world request
      r.get 'world' do
        "#{@greeting} world!"
      end

      # /hello request
      r.is do
        # GET /hello request
        r.get do
          "#{@greeting}!"
        end

        # POST /hello request
        r.post do
          puts "Someone said #{@greeting}!"
          r.redirect
        end
      end
    end

    r.on 'a' do           # /a branch
      r.on 'b' do         # /a/b branch
        r.is 'c' do       # /a/b/c request
          r.get do
            'Request from a/b/c'
          end
          r.post {} # POST /a/b/c request
        end
        r.get 'd' do
          'Request from d'
        end
        r.post 'e' do 
        end # POST /a/b/e request
      end
    end

    # GET /post/2011/02/16/hello
    r.get "post", Integer, Integer, Integer, String do |year, month, day, slug|
      "#{year}-#{month}-#{day} #{slug}" #=> "2011-02-16 hello"
    end

    # /search?q=barbaz
    r.get "search" do
      "Searched for #{r.params['q']}" #=> "Searched for barbaz"
    end

    r.is ["login", "Login"] do
      # GET /login
      r.get do
        "Login"
      end

      # POST /login?user=foo&password=baz
      r.post do
        "#{r.params['user']}:#{r.params['password']}" #=> "foo:baz"
      end
    end

  end
end
