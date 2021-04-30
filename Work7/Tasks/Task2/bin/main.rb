# frozen_string_literal: true

require_relative '../lib/workers_list'

def main
  workers_list = WorkersList.new
  workers_list.read_yaml(File.expand_path('../data/workers.yaml', __dir__))
  workers_list.create_html
end

main if __FILE__ == $PROGRAM_NAME
