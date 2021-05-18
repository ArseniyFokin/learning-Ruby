# encoding: utf-8

require "roda"

class App < Roda
    # вся обработка запросов здесь
    # route - метод для описания пути, который необх обработать
    # данный метод вызывает блок и передаёт ему параметр r
    # благодаря объекту r формируется дерево обработки запросов
  route do |r|
    # GET / request
    r.root do
      r.redirect "/hello"
    end

    # /hello branch
    r.on "hello" do
      # Set variable for all routes in /hello branch
      @greeting = 'Hello!'

      # GET /hello/world request
      r.get "world" do
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

    # 2
    r.on "get"do
      r.get "rng" do
          "#{Случайное значение: rand(100..5000)}"
        end
    end

    # 3
    # /cool/hello/NAME/SURNAME
    r.get "cool","hello",String,String do |name, surname|
      "Hello, #{name} #{surname}!"
    end

    # 4
    # /calc/min/NUM_ONE/NUM_TWO
    # Он должен возвращать минимальное значение из двух целых чисел,
    # переданных в качестве значений NUM_ONE и NUM_TWO. Пример запроса: /calc/min/500/-100
    r.get "calc","min",String,String do |num1,num2|
      "#{[num1.to_i,num2.to_i].min}"
    end

    # 5
    # /calc/multiply/6.5/5.5
    r.get "calc","multiply",String,String do |num1,num2|
      "#{(num1.to_f)*(num2.to_f)}"
    end

    # 6 НЕ РАБОТАЕТ
    # /get/sophisticated/rng?min=100&max=5000
    # r.get "get","sophisticated","rng" do
    #   "mam" # "#{rand((r.params['min'])..(r.params['max']))}"
    # end 

    # r.on "arr"do
    #   r.is "sophisticated" do
    #     r.if "rng" do
    #       r.get do
    #         # "#{rand((r.params['min'])..(r.params['max']))}"
    #         "mam"
    #       end
    #     end
    #   end
    # end
    
    # 7
    # /worker/ID
    


    
    r.on "a" do           # /a branch
        r.on "b" do         # /a/b branch
          r.is "c" do       # /a/b/c request
            r.get do     # GET  /a/b/c request
                "Request from /a/b/c"
            end 
            r.post do end   # POST /a/b/c request
          end
          r.get "d" do   # GET  /a/b/d request
            "Request from 'd"
          end 
          r.post "e" do end # POST /a/b/e request
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
  end
end

