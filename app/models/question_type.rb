class QuestionType < ActiveRecord::Base
  attr_accessible :name

  has_many :questions, :class_name => Question, :foreign_key => "type_id"

  def self.single
    find_by_name("Single Choice")
  end

  def self.multi
    find_by_name("Multi Choice")
  end

end
