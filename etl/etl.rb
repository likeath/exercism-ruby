module ETL
  def self.transform(old)
    old.each_with_object({}) do |(score, letters), result|
      letters.each do |letter|
        result[letter.downcase] = score
      end
    end
  end
end
