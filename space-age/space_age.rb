class SpaceAge
  EARTH_YEAR = 365.25 * 24 * 60 * 60
  PLANETS = {
    mercury: 0.2408467,
    venus: 0.61519726,
    earth: 1.0,
    mars: 1.8808158,
    jupiter: 11.862615,
    saturn: 29.447498,
    uranus: 84.016846,
    neptune: 164.79132
  }

  attr_reader :seconds

  def initialize(seconds)
    @seconds = seconds
  end

  PLANETS.each_key do |planet|
    define_method "on_#{ planet }" do
      on_planet(planet)
    end
  end

  private

  def on_planet(planet)
    seconds / (PLANETS.fetch(planet) * EARTH_YEAR)
  end
end
