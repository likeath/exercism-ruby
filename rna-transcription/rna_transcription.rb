module Complement
  COMPLEMENT_MAP = {
    'G' => 'C',
    'C' => 'G',
    'T' => 'A',
    'A' => 'U'
  }
  COMPLEMENT_REGEXP = Regexp.new(COMPLEMENT_MAP.keys.join('|'))

  def self.of_dna(dna)
    return '' unless valid_dna?(dna)

    dna.gsub(COMPLEMENT_REGEXP, COMPLEMENT_MAP)
  end

  private

  def self.valid_dna?(dna)
    dna.each_char.all? { |element| COMPLEMENT_MAP.key?(element) }
  end

end
