class Year
  def self.leap?(year)
    new(year).leap?
  end

  def initialize(year)
    @year = year
  end

  def leap?
    return false unless evenly_divisible_by_number?(4)
    return true unless evenly_divisible_by_number?(100)
    evenly_divisible_by_number?(400)
  end

  private

  def evenly_divisible_by_number?(num)
    @year.remainder(num).zero?
  end

end

module BookKeeping
  VERSION = 2
end
