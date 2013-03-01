require 'spec_helper'

feature 'Viewing projects' do
	scenario 'Listing all projects' do
		project = Factory.create(:project, :name => 'Gedit')
		visit '/'
		click_link 'Gedit'
		page.current_url.should == project_url(project)
	end
end