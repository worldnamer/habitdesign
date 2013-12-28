require 'spec_helper'

describe Someday do
  it 'should have a description' do
    someday = Someday.create(description: "some description")
    someday.description.should == "some description"
  end  
end