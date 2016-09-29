class Array
  def accumulate(&block)
    result = self.class.new

    each do |element|
      result << block.call(element)
    end

    result
  end
end
