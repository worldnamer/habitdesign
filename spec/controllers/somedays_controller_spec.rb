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

  describe 'POST create' do
    let(:user) { create(:user) }
    before(:each) { sign_in user }

    it 'adds a someday to the user' do
      post :create

      user.somedays.reload.count.should == 1
    end
  end
end