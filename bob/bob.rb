class Bob
  def hey(word)
    if word.strip.empty?
      'Fine. Be that way!'
    elsif word.downcase =~ /[a-z]/ && word.upcase == word
      'Whoa, chill out!'
    elsif word.end_with?('?')
      'Sure.'
    elsif word.strip.empty?
      'Fine. Be that way!'
    else
      'Whatever.'
    end
  end
end
