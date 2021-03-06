require 'spec_helper'

describe ProjectsController do
	let(:user){FactoryGirl.create(:user)}
	before do
		sign_in(user)
	end
	context 'Standard User' do
		{
			new: :get,
			create: :post,
			edit: :get,
			update: :put,
			destroy: :delete
		}.each do |action, method|
			it 'cannot access the #{action} action' do
				send(method, action, :id => FactoryGirl.create(:project))
				expect(response).to redirect_to('/') 
				expect(flash[:alert]).to eql("You must be an admin to do that.")
			end
		end
	end

	it 'cannot access show action without permission' do
		project = FactoryGirl.create(:project)
		get :show,id: project.id
		expect(response).to redirect_to(projects_path)
		expect(flash[:alert]).to have_content("The project you were looking for could not be found.")
	end
end
