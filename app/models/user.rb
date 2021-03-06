class User < ActiveRecord::Base
  has_many :roles
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def to_s
  	"#{email} (#{admin? ? "Admin" : "User"})"
  end

  def generate_api_key
    update_column(:api_key, SecureRandom.hex(16))
  end

  def role_on(project)
  	roles.find_by(project_id: project).try(:name)
  end
end