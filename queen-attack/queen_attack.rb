class Queens
  DEFAULT_POSITIONS = {
    white: [0, 3],
    black: [7, 3]
  }

  def initialize(white: DEFAULT_POSITIONS.fetch(:white), black: DEFAULT_POSITIONS.fetch(:black))
    @white = Figure.new(*white, color: :white)
    @black = Figure.new(*black, color: :black)

    assert_valid_positions

    @board = Board.new.place_figures(@white, @black)
  end

  def white
    @white.position
  end

  def black
    @black.position
  end

  def to_s
    @board.show
  end

  def attack?
    @white.attack?(@black)
  end

  private

  def assert_valid_positions
    fail ArgumentError if @white.same_position?(@black)
  end

  class Figure

    attr_reader :row, :column

    def initialize(row, column, color:)
      @row = row
      @column = column
      @color = color
    end

    def position
      [row, column]
    end

    def type_letter
      @color.to_s[0].upcase
    end

    def attack?(other)
      on_same_row?(other) ||
        on_same_column?(other) |
        on_same_diagonal?(other)
    end

    def same_position?(other)
      row == other.row && column == other.column
    end

    private

    def on_same_row?(other)
      row == other.row
    end

    def on_same_column?(other)
      column == other.column
    end

    def on_same_diagonal?(other)
      (row - other.row).abs == (column - other.column).abs
    end
  end

  class Board
    SIZE = 8

    def initialize
      @board = Array.new(SIZE) { Array.new(SIZE) { '_' } }
    end

    def place_figures(*figures)
      figures.each do |figure|
        @board[figure.row][figure.column] = figure.type_letter
      end
      self
    end

    def show
      @board
        .map { |row| row.join(' ') }
        .join("\n")
    end
  end
end
