class Geopoint
  attr_reader :longitude, :latitude

  def initialize(longitude, latitude)
    @longitude = longitude
    @latitude = latitude
  end

  def to_hash
    { longitude: @longitude, latitude: @latitude }
  end
end