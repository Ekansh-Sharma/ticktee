require 'spec_helper'

feature 'hidden link' do
	let!(:user){FactoryGirl.create(:user)}
	let!(:admin){FactoryGirl.create(:admin_user)}
	let!(:project){FactoryGirl.create(:project)}
	context "anonymous users" do
		scenario 'cannot see the new project link' do
			visit '/'
			assert_no_link_for 'New Project'
		end
		scenario 'cannot see the edit project link' do
			visit project_path(project)
			assert_no_link_for 'Edit Project'
		end
		scenario 'cannot see the Destroy link' do
			visit project_path(project)
			assert_no_link_for 'Destroy'
		end
	end
	context "standered users" do
		before {sign_in_as!(user)}
		scenario 'cannot see the new project link' do
			visit '/'
			assert_no_link_for 'New Project'
		end
		scenario 'cannot see the edit project link' do
			visit project_path(project)
			assert_no_link_for 'Edit Project'
		end
		scenario 'cannot see the Destroy link' do
			visit project_path(project)
			assert_no_link_for 'Destroy'
		end
	end
	context "admin users" do
		before {sign_in_as!(admin)}
		scenario 'see the new project link' do
			visit '/'
			assert_link_for 'New Project'
		end
		scenario 'see the edit project link' do
			visit project_path(project)
			assert_link_for 'Edit Project'
		end
		scenario 'see the Destroy link' do
			visit project_path(project)
			assert_link_for 'Destroy'
		end
	end
end