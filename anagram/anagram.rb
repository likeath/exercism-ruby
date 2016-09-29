class Anagram
  def initialize(word)
    @word = word
  end

  def match(candidates)
    candidates.select do |candidate|
      anagram?(candidate) && not_the_same_word?(candidate)
    end
  end

  private

  def anagram?(candidate)
    prepared_word(candidate) == prepared_word(@word)
  end

  def prepared_word(word)
    word.downcase.split('').sort
  end

  def not_the_same_word?(candidate)
    candidate.downcase != @word.downcase
  end
end
