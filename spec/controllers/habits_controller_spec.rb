require 'spec_helper'

describe HabitsController do
  describe 'GET index' do
    let(:user) { create(:user) }
    before(:each) { sign_in user }

    it 'returns the number of days in the month' do
      Timecop.freeze(Time.new(2013,2,1,0,0,0)) do
        get :index

        assigns(:days_in_month).should == 28
      end
    end

    it 'handles december' do
      Timecop.freeze(Time.new(2013,12,1,0,0,0)) do
        get :index

        assigns(:days_in_month).should == 31
      end
    end
  end

  describe 'POST create' do
    let(:user) { create(:user) }
    before(:each) { sign_in user }

    it 'adds a habit to the user' do
      post :create

      user.habits.reload.count.should == 1
    end
  end

  describe 'PUT update' do
    let(:user) { create(:user) }
    let(:habit) { user.habits.create(description: 'description')}
    before(:each) { sign_in user }

    it 'updates the description of the habit' do
      put :update, {id: habit.id, description: 'new description'}

      habit.reload.description.should == 'new description'
    end
  end
end