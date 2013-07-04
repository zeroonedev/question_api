require 'faker'

class FakeQueston

  attr_accessor :name

  def new
    @name = Faker::Name.name
    super
  end

  def question  
    "Who is #{@name}?"
  end

  def answer
    "#{@name} is a fake."
  end



end