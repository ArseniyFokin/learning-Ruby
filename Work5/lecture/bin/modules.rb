module Trig
  class Math
    #...
  end
  PI = 3.14159254
  def Trig.sin(x)
    #...
  end
  def self.cos(x)
    #...
  end
end

puts Trig::PI
puts Trig.sin(Trig::PI/4)
object = Trig::Math.new
