# XXX I am so lazy
require 'prime'
class Prime
  def self.nth(number)
    assert_valid_number(number)

    lazy.drop(number - 1).first
  end

  private

  def self.assert_valid_number(number)
    fail ArgumentError, 'invalid number' if number < 1
  end
end
