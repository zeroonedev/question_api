require 'spec_helper'

describe User do


  describe "role" do

    before(:each) do
      @user = create(:writer_user)
    end

    it "should be a writer" do
      expect(@user.role.name).to eql("Writer")
    end

    it "should be true " do
      expect(@user.writer?).to be(true)
    end
    
    it "should be false " do
      expect(@user.admin?).to be(false)
    end

    it "should be false " do
      expect(@user.producer?).to be(false)
    end

  end


end
