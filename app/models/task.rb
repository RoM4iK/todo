class Task < ActiveRecord::Base
  self.primary_key = :uuid

  belongs_to :project, :foreign_key => :project_uuid
  validates :title, presence: true
  validates :uuid, presence: true, uniqueness: true
end
