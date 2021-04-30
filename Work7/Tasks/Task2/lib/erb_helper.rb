# frozen_string_literal: true

require 'erb'

# Erb Helper Class
class ErbHelper
  def self.create_erb(path_in, path_out, binding)
    template = File.read(path_in)
    rhtml = ERB.new(template)
    context = binding
    inedex_html = rhtml.result(context)
    file = File.open(path_out, 'w')
    file.write(inedex_html)
  end
end
