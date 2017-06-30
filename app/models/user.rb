class User < ActiveRecord::Base
  include Authority::Abilities
  has_many :posts
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  after_create :assign_default_role, if: Proc.new { User.count > 1 }
  private
  
  def assign_default_role
    add_role :user
  end


end
