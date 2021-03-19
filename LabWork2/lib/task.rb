# frozen_string_literal: true

# Single task class
class Task
  attr_reader :num1, :num2, :ans

  def initialize(num1, num2, ans)
    @num1 = num1
    @num2 = num2
    @ans = ans
  end

  def complexity
    if (@num1 < 10) && (@num2 < 10) && (@ans < 10) && (@ans == @num1 + @num2)
      1
    elsif ((@num1 > 10) && (@num2 < 10)) || ((@num2 > 10) && (@num1 < 10)) ||
          ((@num1 < 10) && (@num2 < 10) && (@ans == @num1 - @num2))
      2
    else
      3
    end
  end
end
