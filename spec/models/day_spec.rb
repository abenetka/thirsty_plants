require "rails_helper"

describe Day do
  it 'exists' do
    day = Day.new(Time.now)
    expect(day).to be_a(Day)
  end
  it "::generate_days" do
    days = Day.generate_days(days_ago: 4, days_from_now: 7)
    expect(days.size).to eq(12)
    expect(days.first).to be_a(Day)
    expect(days.first.css_id).to eq(4.days.ago.strftime('%b%d'))
    expect(days.last.css_id).to eq(7.days.from_now.strftime('%b%d'))
  end
  it ".small_date" do
    today = Day.new(Time.now)
    expect(today.small_date).to eq(Time.now.strftime('%b. %d'))
  end
  it ".css_id" do
    today = Day.new(Time.now)
    expect(today.css_id).to eq(Time.now.strftime('%b%d'))
  end
  it '.css_classes' do
    today = Day.new(Time.now)
    yesterday = Day.new(Time.now - 1.days)
    tomorrow = Day.new(Time.now + 1.days)
    expect(today.css_classes).to eq('row today')
    expect(yesterday.css_classes).to eq('row past-day')
    expect(tomorrow.css_classes).to eq('row')
  end
  it '.month_name' do
    day = Day.new(Time.now)
    expect(day.month_name).to eq(Time.now.strftime('%B'))
  end
  it '.day_of_week_name' do
    day = Day.new(Time.now)
    expect(day.day_of_week_name).to eq(Time.now.strftime('%A'))
  end

  it '.waterings' do
    watering = create(:watering, water_time: Time.now)
    day = Day.new(Time.now, watering.plant.garden.user)
    create(:watering, water_time: 1.days.ago)
    create(:watering, water_time: Time.now)
    expect(day.waterings).to eq([watering])
  end
end