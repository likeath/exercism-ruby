class PhoneNumber
  INVALID_NUMBER = '0000000000'
  CORRECT_NUMBER_LENGTH = 10
  PROBABLY_CORRECT_NUMBER_LENGTH = 11
  OPTIONAL_FIRST_DIGIT = '1'

  attr_reader :number

  def initialize(number_string)
    @number = normalized_number(number_string)
  end

  def area_code
    @number[0..2]
  end

  def to_s
    @number.gsub(/(\d{3})(\d{3})(\d{4})/, '(\1) \2-\3')
  end

  private

  def normalized_number(number)
    return INVALID_NUMBER if number.downcase.match(/[a-z]/)

    number = number.gsub(/\D/, '')

    if number.length == CORRECT_NUMBER_LENGTH
      number
    elsif number.length == PROBABLY_CORRECT_NUMBER_LENGTH && number.start_with?(OPTIONAL_FIRST_DIGIT)
      number[1..-1]
    else
      INVALID_NUMBER
    end
  end
end
