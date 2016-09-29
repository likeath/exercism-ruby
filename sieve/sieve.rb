class Sieve
  require 'prime'

  def initialize(number)
    @number = number
  end

  def primes
    Prime.take_while { |prime| prime <= @number }
  end
end
