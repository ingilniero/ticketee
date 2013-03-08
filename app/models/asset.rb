class Asset < ActiveRecord::Base
	attr_accessible :asset

	belongs_to :ticket

	has_attached_file :asset,
										 path: (Rails.root + 'files/:id/:filename').to_s,
										 url: '/files/:id/:filename'
end
