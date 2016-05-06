require 'spec_helper'
feature 'Creating project' do
	scenario 'can create a project' do
		visit '/'
		click_link 'New Project'
		fill_in 'Name',with: 'Project'
		fill_in 'Description',with: 'First Project'
		click_button 'Create Project'
		expect(page).to have_content('Project has been created.')
		project = Project.where(name: 'Project').first
		expect(page.current_url).to eql(project_url(project))
		title = "Project - Projects - Ticketee"
		expect(page).to have_title(title)
	end	

	scenario 'can not create project with name' do
		visit '/'
		click_link 'New Project'
		click_button 'Create Project'
		expect(page).to have_content("Project has not been created.")
		expect(page).to have_content("Name can't be blank")
	end
	
end