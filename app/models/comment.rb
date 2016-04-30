class Comment < ActiveRecord::Base
  self.primary_key = :uuid

  belongs_to :user
  belongs_to :task, :foreign_key => :task_uuid
  has_attached_file :image, styles: { medium: "500x500>", thumb: "50x50>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
