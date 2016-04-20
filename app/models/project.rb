class Project < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true
  validates :id, presence: true, uniqueness: true
end
