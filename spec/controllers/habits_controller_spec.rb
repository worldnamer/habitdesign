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
end