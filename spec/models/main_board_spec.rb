require 'spec_helper'

describe MainBoard do
  before(:each) do
    @main_board = MainBoard.new(:account=>mock_model("Account"),
                                :title =>"Foo")
  end
  
  it "is valid with valid attributes" do
    @main_board.should be_valid
  end
  
  it "is not valid without a title" do
     @main_board.title = nil
     @main_board.should_not be_valid
   end
   
   it "is not valid without an account" do 
     @main_board.account = nil
     @main_board.should_not be_valid
   end
end