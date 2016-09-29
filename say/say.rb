module Say

  def self.new(number)
    Talker.new(number)
  end

  class Talker
    MAX_VALUE = 1_000_000_000_000

    TRANSLATION = {
      english: {
        0 =>  'zero',
        1 =>  'one',
        2 =>  'two',
        3 =>  'three',
        4 =>  'four',
        5 =>  'five',
        6 =>  'six',
        7 =>  'seven',
        8 =>  'eight',
        9 =>  'nine',
        10 =>  'ten',
        11 =>  'eleven',
        12 =>  'twelve',
        13 =>  'thirteen',
        14 =>  'fourteen',
        15 =>  'fifteen',
        16 =>  'sixteen',
        17 =>  'seventeen',
        18 =>  'eighteen',
        19 =>  'nineteen',
        20 =>  'twenty',
        30 =>  'thirty',
        40 =>  'forty',
        50 =>  'fifty',
        60 =>  'sixty',
        70 =>  'seventy',
        80 =>  'eighty',
        90 =>  'ninety'
      }
    }

    def initialize(number)
      @number = number
      assert_valid_number
    end

    def in_english
      in_language(:english)
    end

    def in_language(language)
      return TRANSLATION.fetch(language)[@number] if TRANSLATION.fetch(language)[@number]

      hundreds, thousands, millions, billions = Utils.number_in_groups_of(@number, 3)
      tens, hundreds = Utils.number_in_groups_of(hundreds, 2)

      [
        Unit::Billion.new(billions).say,
        Unit::Million.new(millions).say,
        Unit::Thousand.new(thousands).say,
        Unit::Hundred.new(hundreds).say,
        Unit::Ten.new(tens).say
      ].compact.join(' ')
    end

    def say_loud_in_english
      system("say #{ Shellwords.escape(in_english) } -v Trinoids")
    end

    private

    def assert_valid_number
      fail ArgumentError unless (0..MAX_VALUE - 1).cover?(@number)
    end
  end

  module Unit
    class Base
      def initialize(value, language = :english)
        @value = value.to_i
        @language = language
      end

      def title
        self.class.name.split(':').last.downcase
      end

      def say
        return if @value.zero?
        "#{ Talker.new(@value).in_language(@language) } #{ title }"
      end
    end

    Billion = Class.new(Base)
    Million = Class.new(Base)
    Thousand = Class.new(Base)
    Hundred = Class.new(Base)

    class Ten
      def initialize(value, language = :english)
        @value = value
        @translation = Talker::TRANSLATION.fetch(language)
      end

      def say
        return if @value.zero?
        return @translation[@value] if @translation[@value]

        tens, ones = @value.to_s.chars.map(&:to_i)
        if tens && ones
          [
            @translation.fetch(tens * 10),
            (@translation.fetch(ones) unless ones.zero?)
          ].compact.join('-')
        else
          @translation.fetch(tens)
        end
      end
    end
  end

  module Utils
    def self.number_in_groups_of(number, group_size)
      number.to_s
        .chars
        .reverse
        .each_slice(group_size)
        .map { |group| group.reverse.join.to_i }
    end
  end
end
