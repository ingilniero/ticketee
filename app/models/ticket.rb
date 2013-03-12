class Ticket < ActiveRecord::Base
	attr_accessible :title, :description, :assets_attributes

	has_many :assets
  belongs_to :project
  belongs_to :user

  validates :title, :description, :presence => true
  validates :description, :length => { :minimum => 10}

  accepts_nested_attributes_for :assets
	has_many :comments

end
