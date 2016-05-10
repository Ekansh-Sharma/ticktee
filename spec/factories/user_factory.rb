FactoryGirl.define do
	factory :user do
		name 'Akash Sharma'
		email 'ekanshsharmacse11@gmail.com'
		password 'password'
		password_confirmation 'password'
		factory :admin_user do
			admin true
		end
	end
end