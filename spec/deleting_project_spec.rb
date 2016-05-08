require 'spec_helper'

feature 'Deleting project' do
	scenario "Delete a project" do
		project = FactoryGirl.create(:project, name: 'First Project')
		visit '/'
		click_link 'First Project'
		click_link 'Destroy'
		expect(page).to have_content("Project has been destroyed.")

		visit "/"
		expect(page).to have_no_content("First Project")
	end 
end