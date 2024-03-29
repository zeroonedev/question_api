class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, 
                  :email, 
                  :password, 
                  :password_confirmation, 
                  :role_id, 
                  :remember_me,
                  :reset_password_sent_at,
                  :remember_created_at,
                  :sign_in_count,
                  :current_sign_in_at,
                  :last_sign_in_at,
                  :current_sign_in_ip,
                  :last_sign_in_ip


  belongs_to :role


  def to_dto
    {
      name: name,
      email: email,
      role: role.to_dto
    }
  end

  def producer?
    role.name == "Producer"
  end

  def admin?
    role.name == "Admin"    
  end

  def writer?
    role.name == "Writer"
  end

  def roles
    [role.name.to_sym]
  end

end
