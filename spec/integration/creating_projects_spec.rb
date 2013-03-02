require 'spec_helper'

feature 'Creating Projects' do
	before do
		sign_in_as!(Factory(:admin_user))
		visit '/'
		click_link 'New Project'
	end

	scenario 'can create a project' do
		fill_in 'Name', :with => 'Gedit'
		fill_in 'Description', :with => 'A text-editor for Linux on Gnome'
		click_button 'Create Project'
		page.should have_content('Project has been created.')

		project = Project.find_by_name('Gedit')
		page.current_url.should == project_url(project)
		title = 'Gedit - Projects - Ticketee'
		find('title').should have_content(title)
	end

	scenario 'can not create a project without a name' do
		click_button 'Create Project'
		page.should have_content('Project has not been created.')
		page.should have_content("Name can't be blank")
	end
end