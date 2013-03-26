class Ticket < ActiveRecord::Base
	attr_accessible :title, :description, :assets_attributes, :tag_names
	attr_accessor :tag_names

	has_many :assets
  belongs_to :project
  belongs_to :user
  belongs_to :state
  has_and_belongs_to_many :tags

  validates :title, :description, :presence => true
  validates :description, :length => { :minimum => 10}

  accepts_nested_attributes_for :assets
	has_many :comments

	before_create :associate_tags

	private

	def associate_tags
		if tag_names
			tag_names.split(" ").each do |name|
				self.tags << Tag.find_or_create_by_name(name)
			end
		end
	end

end
