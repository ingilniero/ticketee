class Project < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :tickets, :dependent => :delete_all

  validates :name, :presence => true, :uniqueness => true

  has_many :permissions, :as => :thing
  def self.viewable_by(user)
  	joins(:permissions).where(:permissions => { :action => 'view',
  																							:user_id => user.id })
  end
  scope :admins, where(:admin => true)

  def self.for(user)
  	user.admin? ? Project : Project.viewable_by(user)
  end
end
