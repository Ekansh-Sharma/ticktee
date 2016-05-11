require 'spec_helper'

describe User do
  describe "passwords" do
  	it "needs a password and confirmation to save" do
  		u = User.new(name: "Ekansh",email: "email@gmail.com")
  		u.save
  		expect(u).to_not be_valid
  		u.password = "password"
  		u.password_confirmation = ""
  		u.save
  		expect(u).to_not be_valid
  		u.password_confirmation = "password"
  		u.save
  		expect(u).to be_valid
  	end

  	it "needs password and confirmation to match" do
  		u = User.new(name: "Ekansh",password: "learner",password_confirmation: "learner1")
  		u.save
  		expect(u).to_not be_valid
  	end
  end

  describe "authentication" do
  	let!(:user){User.create(name: "Ekansh",password: 'learner',password_confirmation: 'learner')} 
  	it "authenticates with a correct password" do
  		expect(user.authenticate("learner")).to be
  	end

  	it "does not authenticate with an incorrect password" do
  		expect(user.authenticate("expert")).to_not be
  	end

    it "requires an email" do
      u = User.new(name: "ekansh",password: 'hunter',password_confirmation: 'hunter')
      u.save
      expect(u).to_not be_valid
      u.email = "abc@gmail.com"
      u.save
      expect(u).to be_valid
    end
  end
end
