# frozen_string_literal: true

require 'roda'

require_relative 'models'

# The core class of the web application for managing test
class TestApp < Roda
  opts[:root] = __dir__
  plugin :environments
  plugin :render

  configure :development do
    plugin :public
    opts[:serve_static] = true
  end

  opts[:tests] = TestList.new([
    Test.new('Лабораторная №1', '2021-04-05', 'Проверка знаний по языку Ruby'),
    Test.new('Лабораторная №2', '2021-04-20',
             'Проверка умений написания приложений на языке Ruby'),
    Test.new('Финальный экзамен', '2021-06-20', 'Проверка всех знаний и умений')
  ])

  route do |r|
    r.public if opts[:serve_static]

    r.root do
      'Hello World'
    end

    r.on 'tests' do
      r.is do
        @params = InputValidators.check_date_description(r.params['date'], r.params['description'])
        @filtered_tests = if @params[:errors].empty?
          opts[:tests].filter(@params[:date], @params[:description])
        else
          opts[:tests].all_tests
        end
        view('tests')
      end

      r.on "new" do
        r.get do
          view('new_test')
        end

        r.post do
          @params = InputValidators.check_test(r.params['name'], r.params['date'], r.params['description'])
          if @params[:errors].empty?
            opts[:tests].add_test(Test.new(@params[:name], @params[:date], @params[:description]))
            r.redirect '/tests'
          else
            view("new_test")
          end
        end
      end
    end
  end
end
