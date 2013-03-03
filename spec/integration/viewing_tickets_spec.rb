require 'spec_helper'

feature 'Viewing tickets' do
	before do
		gedit = Factory(:project, :name => 'Gedit')
		user = Factory(:confirmed_user)
		define_permission!(user, 'view', gedit)
		ticket = Factory(:ticket,
										 :project => gedit,
										 :title => 'Make it shiny!',
										 :description => 'Gradients! Starbursts! Oh my!')
		ticket.update_attribute(:user, user)

		internet_explorer = Factory(:project, :name => 'Internet Explorer')
		define_permission!(user, 'view', internet_explorer)
		Factory(:ticket,
						:project => internet_explorer,
						:title => 'Standards compliance',
						:description => "Isn't a joke.")
		sign_in_as!(user)
		visit '/'
	end

	scenario 'Viewing tickets for a given project' do
		click_link 'Gedit'
		page.should have_content('Make it shiny!')
		page.should_not have_content('Standards compliance')

		click_link 'Make it shiny!'
		within('#ticket h2') do
			page.should have_content('Make it shiny!')
		end
		page.should have_content('Gradients! Starbursts! Oh my!')
	end
end