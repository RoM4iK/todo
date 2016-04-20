class Project < ActiveRecord::Base
  self.primary_key = :uuid

  belongs_to :user#, foreign_key: :user_id
  validates :title, presence: true
  validates :uuid, presence: true, uniqueness: true

end
