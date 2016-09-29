module Grains
  extend self

  MAXIMUM_SQUARE_NUM = 64
  TOTAL_GRAINS_COUNT = 18_446_744_073_709_551_615

  @board = { 1 => 1 }

  def square(number)
    assert_square_number(number)

    @board.fetch(number) do
      fill_board_to_square(number)
      @board.fetch(number)
    end
  end

  def total
    TOTAL_GRAINS_COUNT
  end

  private

  def assert_square_number(number)
    fail ArgumentError if number < 1 || number > MAXIMUM_SQUARE_NUM
  end

  def fill_board_to_square(number)
    (last_filled_square + 1).upto(number) do |i|
      previous_square_value = @board.fetch(i - 1)
      @board[i] = previous_square_value * 2
    end
  end

  def last_filled_square
    @board.size
  end
end
