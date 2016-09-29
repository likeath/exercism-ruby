class Hexadecimal
  BASE = 16
  EQUIVALENT =
    ('A'..'F').map.with_index { |letter, idx| [letter, idx + 10] }.to_h
      .merge(
         (0..9).map { |number| [number.to_s, number] }.to_h
      )

  def initialize(number_string)
    @numbers = number_string.upcase.chars
  end

  def to_decimal
    return 0 unless valid?

    @numbers
      .reverse
      .each_with_index
      .reduce(0) do |result, (number, idx)|
        result += EQUIVALENT.fetch(number) * BASE**idx
      end
  end

  private

  def valid?
    @numbers.all? { |number| EQUIVALENT.key?(number) }
  end
end
