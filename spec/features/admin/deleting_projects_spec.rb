require "rails_helper"

RSpec.feature "Deleting Projects" do
  before do
  	login_as(FactoryGirl.create(:user, :admin))
  end
  scenario "Updating a project" do
    FactoryGirl.create(:project, name: "Sublime Text 3")

    visit "/"
    click_link "Sublime Text 3"
    click_link "Delete Project"

    expect(page).to have_content("Project has been deleted.")

    visit "/"

    expect(page).to have_no_content("Sublime Text 3.")
  end

end