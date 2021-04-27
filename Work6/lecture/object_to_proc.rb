class Greater
  def initialize(greating)
    @greating = greating
  end

  def to_proc
    proc {|name| "#{@greating}, #{name}!"}
  end
end


hi = Greater.new("Hi")
hey = Greater.new("Hey")

pp ["Bob", "Jane"].map(&hi)
pp ["Bob", "Jane"].map(&hey)