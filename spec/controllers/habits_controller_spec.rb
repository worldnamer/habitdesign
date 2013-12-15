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

  describe 'POST set_date' do
    let(:user) { create(:user) }
    let(:habit) { user.habits.create(description: 'description')}
    before(:each) { sign_in user }

    it 'updates the description of the habit' do
      post :set_date, {id: habit.id, date: '2013-12-2'}

      habit.reload.habit_dates.count.should == 1
      habit.habit_dates.first.date.should == Date.new(2013, 12, 2)
    end

    it 'does not create more than one date for the same inputs' do
      post :set_date, {id: habit.id, date: '2013-12-2'}
      post :set_date, {id: habit.id, date: '2013-12-2'}

      habit.reload.habit_dates.count.should == 1
    end
  end
end