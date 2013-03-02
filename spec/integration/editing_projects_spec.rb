require 'spec_helper'

feature 'Editing Projects' do
	before do
		sign_in_as!(Factory(:admin_user))
		Factory(:project, :name => 'Gedit')
		visit '/'
		click_link 'Gedit'
		click_link 'Edit Project'
	end

	scenario 'Updating a project' do
		fill_in 'Name', :with => 'Gedit beta'
		click_button 'Update Project'
		page.should have_content('Project has been updated.')
	end

	scenario 'Updating a project with invalid attributes is bad' do
		fill_in 'Name', :with => ''
		click_button 'Update Project'
		page.should have_content('Project has not been updated.')
	end
end