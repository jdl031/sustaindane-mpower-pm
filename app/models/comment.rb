class Comment < ActiveRecord::Base
  belongs_to :task
  belongs_to :user
  attr_accessible :task_id, :user_id, :comment, :attachment
  has_attached_file :attachment, :storage => :s3, :url => 'sustaindane.s3.amazonaws.com', :bucket => 'sustaindane', :s3_credentials => { :access_key_id => 'AKIAIXH7J4H5JWUAVIUA', :secret_access_key => '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'}
end
