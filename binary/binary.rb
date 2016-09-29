class Binary
  BASE = 2

  def initialize(number)
    assert_valid_number(number)

    @number = number
  end

  def to_decimal
    @number
      .split('')
      .reverse_each
      .with_index
      .reduce(0) { |sum, (num, idx)| sum += num.to_i * BASE**idx }
  end

  private

  def assert_valid_number(number)
    fail ArgumentError, 'invalid number' if number !~ /\A[0-1]+\z/
  end
end

module BookKeeping
  VERSION = 2
end
