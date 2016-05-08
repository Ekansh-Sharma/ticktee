require "spec_helper"

feature 'Viewing projects' do
	scenario 'listing all projects' do
		project = FactoryGirl.create(:project,name: "First Project")
		visit '/'
		click_link "First Project"
		expect(page.current_url).to eql(project_url(project))
	end
end