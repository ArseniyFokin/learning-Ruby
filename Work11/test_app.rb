# frozen_string_literal: true

require 'roda'
require 'forme'

require_relative 'models'

# The core class of the web application for managing test
class TestApp < Roda
  opts[:root] = __dir__
  plugin :environments
  plugin :forme
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
        @params = DryResultFormeAdapter.new(TestFilterFormSchema.call(r.params))
        @filtered_tests = if @params.success?
                              opts[:tests].filter(@params[:date], @params[:description])
                          else
                              opts[:tests].all_tests
                          end
        view('tests')
      end

      r.on "new" do
        r.get do
          @params = {}
          view('new_test')
        end

        r.post do
          @params = DryResultFormeAdapter.new(NewTestFromSchema.call(r.params))
          if @params.success?
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
