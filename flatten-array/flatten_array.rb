module FlattenArray
  VERSION = 1

  def self.flatten(array)
    array.each_with_object([]) do |element, result|
      if element.is_a?(Array)
        result.push(*flatten(element))
      elsif element
        result.push(element)
      end
    end
  end
end
