require 'spec_helper'

describe SomedaysController do
  describe 'GET index' do
    it 'returns the somedays for the active user' do
      user = create(:user)
      user.somedays.create(description: 'test')
      sign_in user

      get :index, {format: :json}

      somedays = JSON.parse(response.body)

      somedays.length.should == 1

      someday = somedays.first
      someday['description'].should == 'test'
    end
  end  
end