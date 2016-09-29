class Crypto
  def initialize(text)
    @text = text.downcase.gsub(/[^a-z0-9]/, '')
    @square = Square.new(@text)
  end

  def size
    @square.size
  end

  def plaintext_segments
    @square.columns.map(&:join)
  end

  def normalize_plaintext
    @text
  end

  def ciphertext_segments
    @square.rows.map(&:join)
  end

  def normalize_ciphertext
    ciphertext_segments.join(' ')
  end

  def ciphertext
    ciphertext_segments.join
  end

  class Square
    def initialize(text)
      @columns_count, @rows_count = find_columns_and_rows_count(text.length)
      @square = form_square(text)
    end

    def size
      @columns_count
    end

    def columns
      @square
    end

    def rows
      @square.transpose
    end

    private

    def find_columns_and_rows_count(length)
      catch :stop do
        (1..length).each do |columns_count|
          (1..length).each do |rows_count|
            if (columns_count >= rows_count) && (columns_count - rows_count <= 1) && (columns_count * rows_count >= length)
              throw :stop, [columns_count, rows_count]
            end
          end
        end
      end
    end

    def form_square(text)
      padding = @columns_count * @rows_count - text.length

      text
        .split('')
        .push(*padding.times.map { '' })
        .each_slice(@columns_count)
        .to_a
    end
  end
end
