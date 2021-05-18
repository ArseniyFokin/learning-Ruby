# frozen_string_literal: true

require 'roda'
require 'yaml'
require 'json'

class Application < Roda

  route do |r|
    r.root do
      r.get do
        "Home page"
      end
    end

    r.get "hello" do
      "Hello!"
    end

    r.on "get" do
      r.get "rng" do
        "Random value: #{Random.new.rand(100..5000)}"
      end

      r.on "sophisticated" do
        r.get "rng" do
          if r.params['min'].nil? and r.params['max'].nil?
            "Not enough arguments"
          elsif !(Integer(r.params['min']) rescue nil) or !(Integer(r.params['max']) rescue nil)
            "Arguments are not integer numbers"
          else
            "Random value: #{Random.new.rand(Integer(r.params['min'])..Integer(r.params['max']))}"
          end
        end
      end
    end

    r.get "/cool", "hello", String, String do |name, surname|
      "Hello, #{name} #{surname}!"
    end

    r.get "calc","min",String,String do |num1,num2|
      "#{[num1.to_i,num2.to_i].min}"
    end

    r.get "calc","multiply",String,String do |num1,num2|
      "#{(num1.to_f)*(num2.to_f)}"
    end

    r.get "worker", String do |id|
      json_data = {"status"=> nil, "data"=> nil}
      if !(Integer(id) rescue nil)
        json_data["status"] = "error"
        json_data["data"] = "Employee ID is an integer."
      else
        id = Integer(id) - 1
        yaml_data = YAML.load_file(File.expand_path('info.yml', __dir__))
        if yaml_data["people"][id].nil?
          json_data["status"] = "error"
          json_data["data"] = "Employee ID was not found in the database."
        else
          json_data["status"] = "sucess"
          json_data["data"] = yaml_data["people"][id]
        end
      end
      JSON.pretty_generate(json_data)
    end

  end
end