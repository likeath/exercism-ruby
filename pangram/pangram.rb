module Pangram
  ALPHABET = [*'a'..'z']

  def self.is_pangram?(string)
    normalized_string = string.downcase

    ALPHABET.all? { |letter| normalized_string.include?(letter) }
  end
end
