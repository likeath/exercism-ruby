module Acronym
  VERSION = 1
  SEPARATOR = ':'
  SPLIT_RULE = Regexp.new([
    '(?=[[:upper:]]+[[:lower]]?)', # uppercase letters followed by lowercase
    '\s+',
    ',',
    '-'
  ].join('|'))

  module_function

  def abbreviate(string)
    string
      .split(SEPARATOR).first
      .split(SPLIT_RULE)
      .map { |word| word[0] }
      .join
      .upcase
  end
end
