class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, 
  # :lockable, :timeoutable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :company_id, :role_id
  # attr_accessible :title, :body

  belongs_to :company
  belongs_to :role
  before_create :set_default_role

  def role_symbols
    [role.name.to_sym]
  end

  private
  def set_default_role
    self.role ||= Role.find_by_name('user')
  end
end
