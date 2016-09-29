module RailFenceCipher
  VERSION = 1

  module_function

  def encode(string, rails_count)
    Encoder.new(string, rails_count).call
  end

  def decode(string, rails_count)
    Decoder.new(string, rails_count).call
  end

  class Worker
    def initialize(string, rails_count)
      @chars = string.chars.each
      @fence = build_fence(string, rails_count)
    end

    def call
      @chars.rewind

      with_fence do |fence|
        fence.map do |row|
          row.map { |char| char = @chars.next if char == '?' }
        end
      end.transpose.flatten.join
    end

    private

    def build_fence(string, rails_count)
      blank_fence = Array.new(rails_count) { Array.new(string.length) }
      rail_position = [*0.upto(rails_count - 1), *(rails_count - 2).downto(1)].cycle

      string
        .length.times
        .with_object(blank_fence) do |char_position, fence|
          fence[rail_position.next][char_position] = '?'
        end
    end
  end

  class Encoder < Worker
    def with_fence
      yield @fence.transpose
    end
  end

  class Decoder < Worker
    def with_fence
      yield @fence
    end
  end
end
