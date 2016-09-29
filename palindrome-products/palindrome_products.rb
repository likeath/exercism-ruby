class Palindromes
  DEFAULT_MIN_FACTOR = 1
  DEFAULT_MAX_FACTOR = 99

  ProductionData = Struct.new(:value, :factors) do
    def palindrome?
      digits = value.to_s.chars
      digits.reverse == digits
    end
  end
  Palindrome = Struct.new(:value, :factors)

  attr_reader :palindromes

  def initialize(max_factor: DEFAULT_MAX_FACTOR, min_factor: DEFAULT_MIN_FACTOR)
    @max_factor = max_factor
    @min_factor = min_factor
  end

  def generate
    return self if @palindromes

    @palindromes = [*@min_factor..@max_factor]
      .permutation(2)
      .lazy
      .map { |factors| ProductionData.new(factors[0] * factors[1], factors) }
      .select(&:palindrome?)
      .group_by(&:value)
      .map { |value, production_data| Palindrome.new(value, production_data.map(&:factors)) }
      .sort_by(&:value)

    self
  end

  def largest
    @palindromes.last
  end

  def smallest
    @palindromes.first
  end

  def palindrome?(value)
    digits = value.to_s.chars
    digits.reverse == digits
  end
end
