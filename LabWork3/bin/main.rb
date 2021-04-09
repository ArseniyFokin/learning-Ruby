# frozen_string_literal: true

require_relative '../lib/notebook'
require_relative '../lib/menu'

def main
  notebook = Notebook.new
  notebook.notebook_load_from_file(File.expand_path('../data/notebook.csv', __dir__))
  menu = Menu.new(notebook)
  menu.start
end

main if __FILE__ == $PROGRAM_NAME
