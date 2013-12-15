require 'spec_helper'

describe HabitsController do
  describe 'GET index' do
    let(:user) { create(:user) }
    let!(:habit) { user.habits.create(description: 'description')}
    before(:each) { sign_in user }

    it 'handles december' do
      Timecop.freeze(Time.new(2013,12,1,0,0,0)) do
        get :index, {format: :json}
      end

      habits = JSON.parse(response.body)

      habits.length.should == 1
      
      habit = habits.first

      habit["days"].length.should == 31
    end

    it 'returns habits for the current user' do
      Timecop.freeze(Time.new(2013,2,1,0,0,0)) do
        get :index, {format: :json}
      end

      habits = JSON.parse(response.body)

      habits.length.should == 1
      
      habit = habits.first
      habit["description"].should == 'description'

      habit["days"].length.should == 28
      habit["days"].each { |day| day.should == 0 }
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