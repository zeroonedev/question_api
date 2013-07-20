class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

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
    role.name == "Writer"    
  end

  def writer?
    role.name == "Writer"
  end

end
