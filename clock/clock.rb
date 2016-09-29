module Clock
  def self.at(hours, minutes)
    ClockTime.new(hours, minutes)
  end

  class ClockTime
    HOURS_IN_DAY = 24
    MINUTES_IN_HOUR = 60
    FORMAT = '%02i'

    attr_reader :hours, :minutes

    def initialize(hours, minutes)
      @hours, @minutes = form_clock(hours, minutes)
    end

    def to_s
      [hours, minutes]
        .map { |e| format(FORMAT, e) }
        .join(':')
    end

    def ==(other)
      hours == other.hours &&
        minutes == other.minutes
    end

    def +(additional_minutes)
      @hours, @minutes = form_clock(hours, minutes + additional_minutes)
      self
    end

    private

    def form_clock(hours, minutes)
      additional_hours, minutes = minutes.divmod(MINUTES_IN_HOUR)
      hours = (hours + additional_hours).remainder(HOURS_IN_DAY)

      [
        process_negative_value(hours, HOURS_IN_DAY),
        process_negative_value(minutes, MINUTES_IN_HOUR)
      ]
    end

    def process_negative_value(value, base)
      if value < 0
        value + base
      else
        value
      end
    end
  end
end

module BookKeeping
  VERSION = 2
end
