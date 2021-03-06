require "rails_helper"

feature "User views list of buses", %{
  As a user I want to see a list of buses
  So that I can select one to read and post reviews

  Acceptance Criteria:

  The bus number must be listed in order
  There is a link to each individual bus page
  The list must include the end destinations
  } do

  scenario "listed in order" do
    bus1 = Bus.create(number: "2", inbound: "Boston", outbound: "New York")
    bus2 = Bus.create(number: "10", inbound: "Boston", outbound: "Providence")
    bus3 = Bus.create(number: "13", inbound: "Boston", outbound: "Albany")
    visit buses_path
    expect(bus1.outbound).to appear_before bus2.outbound
    expect(bus2.outbound).to appear_before bus3.outbound
  end

  scenario "links to individual bus page" do
    bus = Bus.create(number: "2", inbound: "Boston", outbound: "New York")
    visit buses_path
    click_on(bus.number)
    expect(current_path).to eq(bus_path(bus))
  end

  scenario "The list must include the end destinations" do
    bus = Bus.create(number: "2", inbound: "Boston", outbound: "New York")
    visit buses_path
    expect(page).to have_content bus.inbound
    expect(page).to have_content bus.outbound
  end
end
