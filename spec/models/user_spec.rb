require 'spec_helper'

describe User do
  it 'has habits' do
    user = create(:user)
    user.habits.should == []

    user.habits.create(description: 'test')

    user.habits.count.should == 1
  end
end