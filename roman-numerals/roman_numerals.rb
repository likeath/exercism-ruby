class Fixnum
  ROMANS_MAP = {
    1 => 'I',
    4 => 'IV',
    5 => 'V',
    9 => 'IX',
    10 => 'X',
    40 => 'XL',
    50 => 'L',
    90 => 'XC',
    100 => 'C',
    400 => 'CD',
    500 => 'D',
    900 => 'CM',
    1_000 => 'M'
  }

  def to_roman
    return ROMANS_MAP[self] if ROMANS_MAP[self]
    return '' if zero?

    factor = ROMANS_MAP.keys.take_while { |e| e < self }.last

    result = ROMANS_MAP[factor] * div(factor)
    result + remainder(factor).to_roman
  end
end

module BookKeeping
  VERSION = 2
end
