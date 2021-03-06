class Project < ActiveRecord::Base
  self.primary_key = :uuid

  belongs_to :user
  has_many :tasks, :foreign_key => :project_uuid
  validates :title, presence: true
  validates :uuid, presence: true, uniqueness: true

end
