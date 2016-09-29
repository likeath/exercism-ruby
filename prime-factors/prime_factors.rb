require 'prime'
module PrimeFactors
  def self.for(number)
    return [] if number == 1

    result = []
    primes = Prime.each

    loop do
      prime = primes.next
      handler = DivisionHandler.new(number, prime)

      if handler.division_finished?
        result.push(prime)
        break
      elsif handler.successful_divisor?
        result.push(prime)
        number = handler.next_number_value

        primes.rewind
      end
    end

    result
  end

  class DivisionHandler
    def initialize(number, prime)
      @quotient, @modulus = number.divmod(prime)
    end

    def successful_divisor?
      @modulus.zero?
    end

    def division_finished?
      @modulus.zero? && @quotient == 1
    end

    def next_number_value
      @quotient
    end
  end
end
