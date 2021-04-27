class VowelFinder
  include Enumerable

  def initialize(string)
    @string = string
  end

  def each
    @string.scan(/[aoeuyi]/) do |vowel|
      yield vowel
    end
  end
end

finder = VowelFinder.new("Money for nothin")
finder.each do |vowel|
  puts vowel
end

puts (finder.any? {|vowel| vowel =='y'})
pp (finder.map{|vowel| vowel.upcase})
pp (finder.sort)