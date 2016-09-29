module Hamming
  def self.compute(first_strand, second_strand)
    assert_strands_length(first_strand, second_strand)

    first_strand.each_char.with_index.reduce(0) do |difference, (element, idx)|
      difference += 1 if element != second_strand[idx]
      difference
    end
  end

  private

  def self.assert_strands_length(first_strand, second_strand)
    fail ArgumentError, 'invalid strands' if first_strand.length != second_strand.length
  end
end
