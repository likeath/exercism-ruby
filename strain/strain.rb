class Array
  def keep
    return enum_for(:keep) unless block_given?

    each_with_object(self.class.new) do |element, result|
      result.push(element) if yield(element)
    end
  end

  def discard
    return enum_for(:discard) unless block_given?

    each_with_object(self.class.new) do |element, result|
      result.push(element) unless yield(element)
    end
  end
end
