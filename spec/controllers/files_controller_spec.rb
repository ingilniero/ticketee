require 'spec_helper'

describe FilesController do
	let(:good_user) { Factory(:confirmed_user) }
	let(:bad_user) { Factory(:confirmed_user, email: 'another@ticketee.com') }

	let(:project) { Factory(:project) }
	let(:ticket) { Factory(:ticket, :project => project,
																	:user => good_user) }

	let(:path) { Rails.root + 'spec/fixtures/speed.txt' }
	let(:asset) do
		ticket.assets.create(:asset => File.open(path))
	end

	before do
		good_user.permissions.create!(:action => 'view',
																	:thing => project)
	end

	context 'users with access' do
		before do
			sign_in(:user, good_user)
		end

		it 'can access assets in project' do
			get 'show', :id => asset.id
			response.body.should eql(File.read(path))
		end
	end

	context 'users without access' do
		before do
			sign_in(:user, bad_user)
		end

		it 'cannot access assets in this project' do
			get 'show', :id => asset.id
			response.should redirect_to(root_path)
			flash[:alert].should eql('The asset you were looking for could not be found.')
		end
	end
end
