class Task < ActiveRecord::Base
  self.primary_key = :uuid

  belongs_to :project, :foreign_key => :project_uuid
  validates :title, presence: true
  validates :uuid, presence: true, uniqueness: true

  acts_as_list scope: :project_uuid, top_of_list: 0

  default_scope { order('position ASC') }
end
