class Role < ActiveRecord::Base
  attr_accessible :name, :user_ids

  has_many :users

  def to_dto
    {
      id: id,
      name: name
    }
  end

end
