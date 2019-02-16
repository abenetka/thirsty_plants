require 'rails_helper'

describe Weather do
  it "exists" do
    index = 0
    lat = "123.00005"
    long = "-0.123496"
    weather = Weather.new(lat, long)

    expect(weather).to be_a(Weather)
  end
  it "has attributes" do
    lat = "123.00005"
    long = "-0.123496"

    weather = Weather.new(lat, long)
    expect(weather.lat).to eq("123.00005")
    expect(weather.long).to eq("-0.123496")
  end
  it "can return the chance of rain" do
    day_index = 0
    lat = "123.00005"
    long = "-0.123496"
    weather_info = {"daily": {
        "summary": "Rain today through Saturday, with high temperatures falling to 49°F on Sunday.",
        "icon": "rain",
        "data": [
            {
                "time": 1550131200,
                "summary": "Rain until afternoon, starting again in the evening, and breezy starting in the afternoon.",
                "icon": "rain",
                "sunriseTime": 1550156511,
                "sunsetTime": 1550195319,
                "moonPhase": 0.32,
                "precipIntensity": 0.061,
                "precipIntensityMax": 0.2176,
                "precipIntensityMaxTime": 1550138400,
                "precipProbability": 0.28}
              ]
            }}

    weather = Weather.new(lat, long)
    weather.stub(:weather_info).and_return(weather_info)
    expect(weather.chance_of_rain(day_index).round(0)).to eq(28)
  end
end
