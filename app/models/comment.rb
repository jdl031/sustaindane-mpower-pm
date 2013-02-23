class Comment < ActiveRecord::Base
  belongs_to :task
  belongs_to :user
  attr_accessible :task_id, :user_id, :comment, :attachment
  has_attached_file :attachment, :storage => :s3, :s3_permissions => :private, :url => ':s3_domain_url', :path => 'comments/:id/attachments/:filename', :s3_credentials => "#{Rails.root}/config/s3.yml"
end
