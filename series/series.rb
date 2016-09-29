class Series
  def initialize(string)
    @numbers = string.split('').map(&:to_i)
  end

  def slices(slice_size)
    assert_valid_slice_size(slice_size)

    @numbers.each_cons(slice_size).to_a
  end

  private

  def assert_valid_slice_size(slice_size)
    fail ArgumentError if slice_size > @numbers.size
  end
end
