class BeerSong
  VERSE_COUNT = 99

  def verse(number)
    Verse.new(number).text
  end

  def verses(from, to)
    (to..from)
      .map { |number| verse(number) }
      .reverse
      .join("\n")
  end

  def lyrics
    verses(VERSE_COUNT, 0)
  end

  class Verse
    def initialize(number)
      @bottle = BottleFactory.new(number)
    end

    def text
      "#{ @bottle.caption.capitalize } of beer on the wall, #{ @bottle.caption } of beer.\n" \
        "#{ @bottle.action_caption }, #{ @bottle.next_bottle_caption } of beer on the wall.\n"
    end
  end

  module BottleFactory
    def self.new(number)
      if number.zero?
        NoBottle.new
      elsif number == 1
        FirstBottle.new(number)
      else
        CommonBottle.new(number)
      end
    end
  end

  class Bottle
    def initialize(number)
      @number = number
    end

    def caption
      "#{ @number } #{ Utils.pluralize('bottle', @number) }"
    end

    def action_caption
      "Take #{ title } down and pass it around"
    end

    def next_bottle_caption
      BottleFactory.new(@number - 1).caption
    end
  end

  class FirstBottle < Bottle
    #TODO: better name
    def title
      'it'
    end
  end

  class CommonBottle < Bottle
    #TODO: better name
    def title
      'one'
    end
  end

  class NoBottle
    def caption
      'no more bottles'
    end

    def action_caption
      'Go to the store and buy some more'
    end

    def next_bottle_caption
      BottleFactory.new(99).caption
    end
  end

  module Utils
    def self.pluralize(word, count)
      return word if count == 1
      "#{ word }s"
    end
  end
end

module BookKeeping
  VERSION = 2
end
