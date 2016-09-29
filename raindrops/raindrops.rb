module Raindrops
  EQUIVALENT = {
    3 => 'Pling',
    5 => 'Plang',
    7 => 'Plong'
  }

  def self.convert(value)
    assert_non_zero_value(value)

    result = translate(value)

    if result.empty?
      value.to_s
    else
      result
    end
  end

  private

  def self.assert_non_zero_value(value)
    fail ArgumentError, 'zero supplied' if value.zero?
  end

  def self.translate(value)
    EQUIVALENT.keys.reduce('') do |memo, factor|
      memo << EQUIVALENT[factor] if value % factor == 0
      memo
    end
  end

end
