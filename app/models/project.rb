class Project < ActiveRecord::Base
  self.primary_key = :id

  belongs_to :user
  validates :title, presence: true
  validates :id, presence: true, uniqueness: true
end
