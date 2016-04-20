class Project < ActiveRecord::Base
  self.primary_key = :uuid

  belongs_to :user
  validates :title, presence: true
  validates :uuid, presence: true, uniqueness: true
  
end
