require 'rails_helper'

describe 'as a visitor' do
  it "should not be able to see webpages if not logged in" do
    garden = create(:garden)

    visit dashboard_path
    expect(page).to have_content("The page you were looking for doesn't exist.")
    expect(page.status_code).to eq(404)

    visit new_garden_plant_path(garden)
    expect(page).to have_content("The page you were looking for doesn't exist.")
    expect(page.status_code).to eq(404)

    visit new_garden_plant_path(garden)
    expect(page).to have_content("The page you were looking for doesn't exist.")
    expect(page.status_code).to eq(404)

    visit new_garden_path
    expect(page).to have_content("The page you were looking for doesn't exist.")
    expect(page.status_code).to eq(404)

    visit edit_garden_path(garden)
    expect(page).to have_content("The page you were looking for doesn't exist.")
    expect(page.status_code).to eq(404)

    visit garden_path(garden)
    expect(page).to have_content("The page you were looking for doesn't exist.")
    expect(page.status_code).to eq(404)

  end
end
