require 'spec_helper'

feature 'Viewing Tickets' do
	before do
		user = FactoryGirl.create(:user)
		textmate_2 = FactoryGirl.create(:project,
                                    name: "TextMate 2")
    ticket = FactoryGirl.create(:ticket,
            project: textmate_2,
            title: "Make it shiny!",
            description: "Gradients! Starbursts! Oh my!")
    ticket.update(user: user)
    internet_explorer = FactoryGirl.create(:project,
                                           name: "Internet Explorer")
    ticket = FactoryGirl.create(:ticket,
            project: internet_explorer,
            title: "Standards compliance",
            description: "Isn't a joke.")
    ticket.update(user: user)
		visit '/'
	end
	scenario 'Viewing project for a given project' do
		click_link 'TextMate 2'
		expect(page).to have_content("Make it shiny!")
		expect(page).not_to have_content("Standards compliance")
		click_link 'Make it shiny!'
		within("#ticket h2") do
			expect(page).to have_content("Make it shiny!")
		end
		expect(page).to have_content("Gradients! Starbursts! Oh my!")
	end
end