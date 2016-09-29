class Game
  ROUNDS = 10

  attr_reader :frames
  def initialize
    @frames = []
  end

  def roll(pins_count)
    if @current_frame && @current_frame.finished?
      @frames.push(@current_frame)
      @current_frame = Frame.new
      @current_frame.roll(pins_count)
    elsif @current_frame
      @current_frame.roll(pins_count)
    else
      @current_frame = Frame.new
      @current_frame.roll(pins_count)
    end
  end

  def score
    fail RuntimeError, 'Score cannot be taken until the end of the game' if @frames.size < ROUNDS - 1
    @frames << @current_frame

    sum = 0
    @frames.each_with_index do |frame, idx|
      if frame.opened?
        sum += frame.rolls_sum
      elsif frame.strike?
        sum += strike_sum(frame, idx)
      elsif frame.spare?
        sum += spare_sum(frame, idx)
      end
    end

    sum
  end

  def spare_sum(frame, idx)
    frame.rolls_sum + @frames[idx + 1].first_roll_score
  end

  def strike_sum(frame, idx)
    frame.rolls_sum + @frames[idx + 1].rolls_sum
  end

  class Frame
    MAX_PIN_SIZE = 10
    MAX_ROLLS_COUNT = 2

    def initialize
      @rolls = []
    end

    def roll(pins)
      assert_valid_pins(pins)

      @rolls.push(pins)
    end

    def assert_valid_pins(pins)
      fail RuntimeError, 'Pins must have a value from 0 to 10' unless [*0..MAX_PIN_SIZE].include?(pins)
      fail RuntimeError, 'Pin count exceeds pins on the lane' if (rolls_sum + pins > MAX_PIN_SIZE) || finished?
    end

    def strike?
      first_roll_score == MAX_PIN_SIZE
    end

    def spare?
      !strike? && (rolls_sum == MAX_PIN_SIZE)
    end

    def finished?
      strike? || spare? || @rolls.size == MAX_ROLLS_COUNT
    end

    def opened?
      rolls_sum < MAX_PIN_SIZE
    end

    def rolls_sum
      @rolls.reduce(0, :+)
    end

    def first_roll_score
      @rolls.first
    end
  end

end

module BookKeeping
  VERSION = 1
end
