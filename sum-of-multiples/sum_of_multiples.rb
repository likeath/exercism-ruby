require 'set'
class SumOfMultiples
  def initialize(*numbers)
    @numbers = numbers
    @multiples = Set.new
  end

  def to(limit)
    fetch_multiples(limit)
    @multiples.reduce(0, :+)
  end

  private

  def fetch_multiples(limit)
    @numbers.each do |number|
      multiples = (1..Float::INFINITY)
        .lazy
        .map { |i| number * i }
        .take_while { |e| e < limit }
        .to_a

      @multiples.merge(multiples)
    end
  end
end
