require 'spec_helper'

feature 'Hidden Links' do
  context "Standard User" do
    let!(:user){ FactoryGirl.create(:user) }
    let!(:project){ FactoryGirl.create(:project)}
    let!(:ticket){ FactoryGirl.create(:ticket, project: project, user: user)}
    before do
      sign_in_as!(user)
    end
    scenario "New ticket is shown to a user with permission" do
      define_permission!( user, "view", project)
      define_permission!( user,"create tickets", project)
      visit project_path(project)
      assert_link_for "New Ticket"
    end
    scenario "New ticket link is hidden from a user without permission" do
      define_permission!( user, "view", project)
      visit project_path(project)
      assert_no_link_for "New Ticket"
    end
    scenario "Edit ticket link is shown to a user with permission" do
      define_permission!( user, "view", project)
      define_permission!( user, "edit tickets", project)
      visit project_path(project)
      click_link ticket.title
      assert_link_for "Edit Ticket"
    end
    scenario "Edit ticket link is hidden to a user without permission" do
      define_permission!( user, "view", project)
      visit project_path(project)
      click_link ticket.title
      assert_no_link_for "Edit Ticket"
    end
    scenario "Delete ticket link is shown to a user with permission" do
      define_permission!( user, "view", project)
      define_permission!( user, "delete tickets", project)
      visit project_path(project)
      click_link ticket.title
      assert_link_for "Delete Ticket"
    end
    scenario "Delete ticket link is hidden to a user without permission" do
      define_permission!( user, "view", project)
      visit project_path(project)
      click_link ticket.title
      assert_no_link_for "Delete Ticket"
    end
  end

  context "Admin User" do
    let!(:admin){ FactoryGirl.create(:admin_user) }
    let!(:project){ FactoryGirl.create(:project)}
    let!(:ticket){ FactoryGirl.create(:ticket, project: project, user: admin)}
    before do
      sign_in_as!(admin)
    end
    scenario "New ticket is shown to admins" do
      visit project_path(project)
      assert_link_for "New Ticket"
    end
    scenario "Edit ticket is shown to admins" do
      visit project_path(project)
      click_link ticket.title
      assert_link_for "Edit Ticket"
    end
    scenario "Delete ticket is shown to admins" do
      visit project_path(project)
      click_link ticket.title
      assert_link_for "Delete Ticket"
    end
  end

end
