# frozen_string_literal: true

require 'yaml'

require_relative 'worker'
require_relative 'erb_helper'

# Class describing all workers
class WorkersList
  def initialize
    @workers_list = []
  end

  def read_yaml(path)
    yaml = YAML.load_file(path)
    yaml['people'].each do |worker|
      @workers_list.push(Worker.new(worker))
    end
  end

  def get_binding
    binding
  end

  def create_html
    @workers_list.each do |worker|
      ErbHelper.create_erb(File.expand_path('../templates/worker.erb', __dir__),
                           File.expand_path("../view/#{worker.name + worker.surname}.html",
                                            __dir__),
                           worker.get_binding)
    end
    ErbHelper.create_erb(File.expand_path('../templates/workers_list.erb', __dir__),
                         File.expand_path('../view/index.html', __dir__),
                         get_binding)
  end
end
