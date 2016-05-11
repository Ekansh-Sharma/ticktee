require 'spec_helper'

feature 'deleting a user' do
	let!(:admin){FactoryGirl.create(:admin_user)}
	let!(:user){FactoryGirl.create(:user)}
	before do
		sign_in_as!(admin)
		visit '/'
		click_link 'Admin'
		click_link 'Users'
	end
	scenario 'deleting a user' do
		click_link user.email
		click_link 'Delete User'
		expect(page).to have_content("You cannot delete yourself!")
	end
end