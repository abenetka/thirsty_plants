require 'rails_helper'

describe 'As a logged-in user, I see the dashboard' do
  it 'no gardens created' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Garden Dashboard")
    expect(page).to have_button("Create Garden")
    expect(user.gardens.count).to eq(0)
    expect(page).to have_content("No Gardens Created Yet!")
  end

  it 'gardens created' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    garden_1 = create(:garden, user: user)
    garden_2 = create(:garden, user: user)
    garden_3 = create(:garden, user: user)

    visit dashboard_path

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Garden Dashboard")
    expect(page).to have_button("Create Garden")
    expect(user.gardens.count).to eq(3)

    within "#garden-#{garden_1.id}" do
      expect(page).to have_content(garden_1.name)
      expect(page).to have_content(garden_1.zip_code)
      expect(page).to have_link("#{garden_1.name}")
    end

    within "#garden-#{garden_2.id}" do
      expect(page).to have_content(garden_2.name)
      expect(page).to have_content(garden_2.zip_code)
      click_on("#{garden_2.name}")
      expect(current_path).to eq(garden_path(garden_2))
    end
  end

  it "sees weather data" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    garden = create(:garden, user: user, name: "Backyard", lat: "1.342432", long: "-0.00045580")
    visit dashboard_path

    today = Time.now
    within("#garden-#{garden.id}") do
      expect(page).to have_content("Weather in #{garden.name}:")
      expect(page).to have_css('.weather_day', count: 7)
      expect(page).to have_content("#{today.strftime('%A')}")
      expect(page).to have_content("#{(today + 1.days).strftime('%A')}")
      expect(page).to have_content("#{(today + 2.days).strftime('%A')}")
      expect(page).to have_content("#{(today + 3.days).strftime('%A')}")
      expect(page).to have_content("#{(today + 4.days).strftime('%A')}")
      expect(page).to have_content("#{(today + 5.days).strftime('%A')}")
      expect(page).to have_content("#{(today + 6.days).strftime('%A')}")
    end
  end
end
