require 'rails_helper'

RSpec.describe TicketsController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }
  it "can create tickets, but not tag them" do
    post :create, ticket: { title: "New ticket!",
                               description: "Brand spankin' new",
                               tag_names: "these are tags"
                             },
                  project_id: project.id
    expect(Ticket.last.tags).to be_empty
  end
end
