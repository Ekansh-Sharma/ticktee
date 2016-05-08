require 'spec_helper'
feature 'Editing project' do 
	before do 
		project = FactoryGirl.create(:project,name: "First Project")
		visit '/'
		click_link 'First Project'
		click_link 'Edit Project'
	end
	scenario "Updating a project" do
		fill_in 'Name', with: 'Update Project'
		click_button 'Update Project'
		expect(page).to have_content("Project has been updated.")
	end
	scenario "Updating project with invalid attributes" do
		fill_in 'Name', with: ''
		click_button 'Update Project'
		expect(page).to have_content("Project has not been updated.")
	end
end