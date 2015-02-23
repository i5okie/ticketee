require "rails_helper"

feature "Ticket Notifications" do
  let!(:alice) { FactoryGirl.create(:user, email: "alice@example.com") }
  let!(:bob) { FactoryGirl.create(:user, email: "bob@example.com") }
  let!(:project) { FactoryGirl.create(:project) }
  let!(:ticket) do
    FactoryGirl.create(:ticket, project: project, author: alice)
  end

  before do
    assign_role!(alice, :manager, project)
    assign_role!(bob, :manager, project)

    login_as(bob)
    visit "/"
  end

  scenario "Ticket owner receives notifications about comments" do
    click_link project.name
    click_link ticket.title
    fill_in "Text", with: "Is it out yet?"
    click_button "Create Comment"

    email = find_email!(alice.email)
    subject = "[ticketee] #{project.name} - #{ticket.title}"
    expect(email.subject).to include(subject)
    click_first_link_in_email(email)

    within("#ticket h2") do
      expect(page).to have_content(ticket.title)
    end
  end

  scenario "comment authors are automatically subscribed to a ticket" do
    click_link project.name
    click_link ticket.title
    fill_in "Text", with: "Is it out yet?"
    click_button "Create Comment"
    click_link "Sign out"

    reset_mailer

    login_as(alice)
    visit project_ticket_path(project, ticket)
    fill_in "Text", with: "Not yet - sorry!"
    click_button "Create Comment"

    expect(page).to have_content("Comment has been created.")
    expect(unread_emails_for(bob.email).count).to eq 1
    #expect(unread_emails_for(alice.email).count).to eq 1
  end
end