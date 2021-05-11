# frozen_string_literal: true

require 'roda'

require_relative 'models'

# The core class of the web application for managing test
class StudentsApp < Roda
  opts[:root] = __dir__
  plugin :environments
  plugin :render

  configure :development do
    plugin :public
    opts[:serve_static] = true
  end

  opts[:institutions] = InstituteList.new
  opts[:institutions].read_csv(File.expand_path('models/students.csv', __dir__))

  route do |r|
    r.public if opts[:serve_static]

    r.root do
      @params = opts[:institutions].all_institute
      view('institutions')
    end

    r.on 'tests' do
      
    end
  end
end