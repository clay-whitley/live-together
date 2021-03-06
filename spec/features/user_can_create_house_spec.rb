require 'spec_helper'

feature "user can create a house", feature: true do

  let(:user) { FactoryGirl.build(:user) }
  let(:house) { FactoryGirl.build(:house) }

  before do
    sign_up_through_view(user)
    visit root_path
  end

  it "displays the create house form" do
    expect(page).to have_content "Create house"
  end

  it "successfully creates a new house with valid data" do
    fill_in "house_name", with: house.name
    fill_in "house_address", with: house.address
    click_button "Create house"
    expect(page).to have_content house.name
    expect(page).to have_content house.address
  end
end