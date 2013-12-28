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

  describe 'DELETE destroy' do
    let(:user) { create(:user) }
    let!(:someday) { user.somedays.create(description: 'description')}
    before(:each) { sign_in user }

    it 'removes the someday' do
      delete :destroy, {id: someday.id}

      user.reload.somedays.length.should == 0
    end

    it 'does not remove somedays unless they belong to you' do
      other_user_someday = create(:someday)
      other_user = other_user_someday.user

      delete :destroy, {id: other_user_someday.id}

      other_user.reload.somedays.length.should == 1
    end
  end
end