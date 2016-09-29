class Squares
  def initialize(value)
    @range = (1..value)
  end

  def square_of_sum
    @square_of_sum ||= @range.reduce(0, :+)**2
  end

  def sum_of_squares
    @sum_of_squares ||= @range.map { |e| e**2 }.reduce(0, :+)
  end

  def difference
    square_of_sum - sum_of_squares
  end
end
