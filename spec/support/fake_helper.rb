require 'faker'

puts "loading FakeHelper::FakeQueston"
module FakeHelper
  class FakeQueston

    attr_accessor :name

    def self.fabricate
      FakeQueston.new
      [question, answer]
    end

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
end