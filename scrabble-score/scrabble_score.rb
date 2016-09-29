class Scrabble
  module Utils
    def self.normalize_score_map(score_map)
      score_map.flat_map do |letters, score|
        Array(letters).map { |letter| [letter.upcase, score] }
      end.to_h
    end
  end

  SCORES = Utils.normalize_score_map([
    [%w(A E I O U L N R S T), 1],
    [%w(D G)                , 2],
    [%w(B C M P)            , 3],
    [%w(F H V W Y)          , 4],
    [%w(K)                  , 5],
    [%w(J X)                , 8],
    [%w(Q Z)                , 10]
  ]).freeze

  DEFAULT_MODIFIER = 1
  EMPTY_SCORE = 0

  def self.score(word, word_modifier: DEFAULT_MODIFIER, letters_modifier: {})
    new(
      word,
      word_modifier: word_modifier,
      letters_modifier: letters_modifier
    ).score
  end

  def initialize(word, word_modifier: DEFAULT_MODIFIER, letters_modifier: {})
    @word = word.to_s.strip.upcase
    @word_modifier = word_modifier
    @letters_modifier = Utils.normalize_score_map(letters_modifier)
  end

  def score
    return EMPTY_SCORE if @word.empty?

    word_score = @word.chars
      .map { |letter| score_for_letter(letter) }
      .reduce(0, :+)

    word_score * @word_modifier
  end

  private

  def score_for_letter(letter)
    SCORES.fetch(letter, EMPTY_SCORE) *
      @letters_modifier.fetch(letter, DEFAULT_MODIFIER)
  end
end
