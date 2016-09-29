module RunLengthEncoding
  def self.encode(string)
    string
      .each_char
      .each_with_object(EncodeTracker.new) do |character, tracker|
        tracker.process_character(character)
      end.result
  end

  def self.decode(string)
    string
      .scan(/\d*[^0-9]/)
      .map { |group| EncodedGroup.new(group).decode }
      .join
  end

  class EncodeTracker
    CurrentCharacter = Struct.new(:character, :occurences) do
      def encode
        return '' if occurences.zero?
        return character if occurences == 1
        "#{ occurences }#{ character }"
      end
    end

    def initialize
      reset_current_character
      @result = ''
    end

    def process_character(character)
      if character != @current_character.character
        add_current_to_result
        track_new_character(character)
      else
        increase_occurences
      end
    end

    def result
      finalize
      @result
    end

    private

    def reset_current_character
      @current_character = CurrentCharacter.new('', 0)
    end

    def add_current_to_result
      @result << @current_character.encode
    end

    def track_new_character(character)
      @current_character = CurrentCharacter.new(character, 1)
    end

    def increase_occurences
      @current_character.occurences += 1
    end

    def finalize
      add_current_to_result
      reset_current_character
    end
  end

  class EncodedGroup
    def initialize(group)
      @character = group.match(/[^0-9]/)[0]
      @count = if (matches = group.match(/\d+/))
                matches[0].to_i
              else
                1
              end
    end

    def decode
      @character * @count
    end
  end
end

module BookKeeping
  VERSION = 2
end
