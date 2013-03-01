require 'spec_helper'

feature 'Deleting projects' do
	scenario 'Deleting a project' do
		Factory(:project, :name => 'Gedit')
		visit '/'
		click_link 'Gedit'
		click_link 'Delete Project'
		page.should have_content('Project has been deleted.')

		visit '/'
		page.should_not have_content('Gedit')
	end
end
