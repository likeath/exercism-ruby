class Nucleotide
  NUCLEOTIDES = %w(A C G T).freeze

  def self.from_dna(dna)
    new(dna)
  end

  def initialize(dna)
    @dna = dna.chars

    assert_valid_dna

    @histogram = {}
  end

  def count(nucleotide)
    @histogram.fetch(nucleotide) do
      fetch_nucleotide(nucleotide)
    end
  end

  def histogram
    fetch_all_nucleotides
    @histogram
  end

  private

  def assert_valid_dna
    fail ArgumentError unless @dna.all? { |nucleotide| NUCLEOTIDES.include?(nucleotide) }
  end

  def fetch_nucleotide(nucleotide)
    @dna
      .count { |element| element == nucleotide }
      .tap { |count| add_to_historam(nucleotide, count) }
  end

  def fetch_all_nucleotides
    NUCLEOTIDES.each do |nucleotide|
      count(nucleotide)
    end
  end

  def add_to_historam(nucleotide, count)
    @histogram[nucleotide] = count
  end
end
