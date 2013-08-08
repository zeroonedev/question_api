class RoundType < ActiveRecord::Base
  attr_accessible :name,
                  :question_type_id,
                  :number_of_questions,
                  :number_of_spares

  has_many :rounds
  belongs_to :question_type
end
