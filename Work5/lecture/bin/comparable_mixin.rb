class SizeMatters
  include Comparable
  attr :str
  def <=>(other)
    # =0 - Равны
    # >0 - Больше
    # <0 - Меньше
    str.size <=> other.str.size
  end
  def initialize(str)
    @str = str
  end
end
  
s1 = SizeMatters.new("Z")
s2 = SizeMatters.new("YY")
s3 = SizeMatters.new("XXX")
puts s1 < s2
print([s1, s2, s3].sort()) 