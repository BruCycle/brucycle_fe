require 'rails_helper'

RSpec.describe 'User-Edit' do
  describe 'Update to username' do
    before(:each) do
      @json = File.read('spec/fixtures/user_data.json')
      @json2 = File.read('spec/fixtures/user_activities.json')
      @user_id = 62
      stub_request(:get, 'http://localhost:3000/api/v1/user?')
        .to_return(status: 200, body: @json)

      stub_request(:get, 'http://localhost:3000/api/v1/activities?')
        .to_return(status: 200, body: @json2)

      @user = create(:user)
      
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'user can edit their username' do
      visit '/user/edit'

      fill_in("Username", with: 'Jasper')
      click_button 'Update'

      expect(current_path).to eq('/dashboard')

      user = User.find(@user.id)
      expect(user.username).to eq('Jasper')
    end
  end
end
