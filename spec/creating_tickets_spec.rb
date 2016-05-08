require 'spec_helper'

feature 'Cretaing tickets' do
	before do
		FactoryGirl.create(:project,name: 'Google Chrome')
		visit '/'
		click_link 'Google Chrome'
		click_link 'New Ticket'
	end

	scenario 'Creating a ticket' do
		fill_in 'Title', with: 'Non-standards compliance'
		fill_in 'Description', with: 'My pages are ugly!'
		click_button 'Create Ticket'
		expect(page).to have_content("Ticket has been created.")
	end

	scenario 'Creating a ticket with invalid attributes' do
		click_button 'Create Ticket'
		expect(page).to have_content("Ticket has not been created.")
		expect(page).to have_content("Title can't be blank")
		expect(page).to have_content("Description can't be blank")
	end

	scenario 'Ticket description should be atleast 10 character' do
		fill_in 'Title', with: 'Non-standards compliance'
		fill_in 'Description', with: 'It sucks.'
		click_button 'Create Ticket'
		expect(page).to have_content("Ticket has not been created.")
		expect(page).to have_content("Description is too short")
	end
end