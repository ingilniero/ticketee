class Ticket < ActiveRecord::Base
	attr_accessible :title, :description, :asset

  belongs_to :project
  belongs_to :user
  attr_accessible :description, :title

  validates :title, :description, :presence => true
  validates :description, :length => { :minimum => 10}

  has_attached_file :asset
end
