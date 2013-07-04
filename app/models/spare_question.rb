class SpareQuestion < Question 

  before_create :set_assoiation_id

  def set_association_id
    spare_id = id
  end

  def promote
    spare_id = nil
    save
    super.find(id)
  end

end