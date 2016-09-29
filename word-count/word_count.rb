class Phrase
  def initialize(phrase)
    @phrase = phrase.downcase
      .split(/\s+|,/)
      .map { |word| normalize_word(word) }
      .reject(&:empty?)
  end

  def word_count
    @phrase
      .group_by { |word| word }
      .map { |word, occurences| [word, occurences.size] }
      .to_h
  end

  private

  def normalize_word(word)
    word.gsub(/[^0-9a-z']/, '').gsub(/\A('?)(\w+)'\z/, '\\2')
  end
end

module BookKeeping
  VERSION = 1
end
