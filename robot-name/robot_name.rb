class Robot
  @names = []

  attr_reader :name

  def self.add_name(name)
    @names << name
  end

  def self.valid_name?(name)
    !@names.include?(name)
  end

  def initialize
    set_name
  end

  def reset
    set_name
  end

  private

  def set_name
    @name = generate_name
  end

  def generate_name
    loop do
      name_candidate = ([*'A'..'Z'].shuffle.take(2) + [*1..9].shuffle.take(3)).join

      if self.class.valid_name?(name_candidate)
        self.class.add_name(name_candidate)
        break name_candidate
      end
    end
  end
end

module BookKeeping
  VERSION = 2
end
