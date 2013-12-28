require 'spec_helper'

describe HabitsController do
  describe 'GET index' do
    let(:user) { create(:user) }
    before(:each) { sign_in user }

    it 'handles december' do
      Timecop.freeze(Date.new(2013,12,10)) do
        user.habits.create(description: 'description')
      end

      get :index, {format: :json, startDate: '2013-12-1', endDate: '2013-12-31'}

      habits = JSON.parse(response.body)

      habits.length.should == 1
      
      habit = habits.first

      habit["days"].length.should == 31
    end

    it 'returns habits for the current user' do
      Timecop.freeze(Date.new(2013,2,10)) do
        user.habits.create(description: 'description')
      end

      get :index, {format: :json, startDate: '2013-2-1', endDate: '2013-2-28'}

      habits = JSON.parse(response.body)

      habits.length.should == 1
      
      habit = habits.first
      habit["description"].should == 'description'

      habit["days"].length.should == 28
      habit["days"].each { |day| day.should == 0 }
    end

    it 'does not return habits before their creation date' do
      user.habits.create(description: 'description')

      get :index, {format: :json, startDate: 5.days.ago.strftime('%Y-%-m-%-d'), endDate: 4.days.ago.strftime('%Y-%-m-%-d')}

      habits = JSON.parse(response.body)

      habits.length.should == 0
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

  describe 'DELETE remove_date' do
    let(:user) { create(:user) }
    let!(:habit) { user.habits.create(description: 'description')}
    let!(:date) { user.habits.first.habit_dates.create(date: Date.new(2013,12,2))}
    before(:each) { sign_in user }

    it 'removes the date' do
      delete :remove_date, {id: habit.id, date: '2013-12-2'}

      habit.reload.habit_dates.count.should == 0
    end

    it 'does not balk at removing the same date twice' do
      delete :remove_date, {id: habit.id, date: '2013-12-2'}
      delete :remove_date, {id: habit.id, date: '2013-12-2'}
    end
  end

  describe 'DELETE destroy' do
    let(:user) { create(:user) }
    let!(:habit) { user.habits.create(description: 'description')}
    before(:each) { sign_in user }

    it 'removes the habit' do
      delete :destroy, {id: habit.id}

      user.reload.habits.length.should == 0
    end

    it 'does not remove habits unless they belong to you' do
      other_user_habit = create(:habit)
      other_user = other_user_habit.user

      delete :destroy, {id: other_user_habit.id}

      other_user.reload.habits.length.should == 1
    end
  end
end