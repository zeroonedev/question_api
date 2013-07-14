class FormMetadataFactory

  def self.build
    {
      writers: Writer.all.unshift(all_id_option),
      categories: Category.all.unshift(all_id_option),
      difficulties: Difficulty.all.unshift(all_id_option),
      question_types: QuestionType.all.unshift(all_id_option),
      producers: Producer.all.unshift(all_id_option),
      verified_options: [
        all_value_option,
        { name: "Verified", value: true },
        { name: "Un-verified", value: false }
      ]
    }
  end

  def self.all_value_option
    { name: "All", value: "?" }
  end

  def self.all_id_option
    { name: "All", id: "?" }
  end

end