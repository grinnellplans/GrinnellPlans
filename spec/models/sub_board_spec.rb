require 'spec_helper'

describe SubBoard do
  before(:each) do
    @sub_board = SubBoard.new(:threadid=>1, :userid=>1, :contents=>"foo")
  end
  
  it "is valid with valid attributes" do
     @sub_board.should be_valid
  end
  
  it "is not valid without a threadid" do
     @sub_board.threadid = nil
     @sub_board.should_not be_valid
  end
  
  it "is not valid without a userid" do
     @sub_board.userid = nil
     @sub_board.should_not be_valid
  end
  
  it "is not valid without contents" do
      @sub_board.contents = nil
      @sub_board.should_not be_valid
   end
   
end