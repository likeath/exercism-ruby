class Trinary
  BASE = 3
  INVALID_VALUE = 0

  def initialize(number)
    @number = number
  end

  def to_decimal
    return INVALID_VALUE unless valid_number?

    @number
      .split('')
      .reverse_each
      .with_index
      .reduce(0) { |sum, (num, idx)| sum += num.to_i * BASE**idx }
  end

  private

  def valid_number?
    @number =~ /\A[0-2]+\z/
  end
end

module BookKeeping
  VERSION = 1
end
