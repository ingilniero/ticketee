require 'spec_helper'

feature 'Creating Projects' do
	scenario 'can create a project' do
		visit '/'
		click_link 'New Project'
		fill_in 'Name', :with => 'Gedit'
		fill_in 'Description', :with => 'A text-editor for Linux on Gnome'
		click_button 'Create Project'
		page.should have_content('Project has been created.')
	end
end