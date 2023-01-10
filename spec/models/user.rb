require 'rails_helper'

RSpec.describe User do 
  describe 'instance methods' do 
    describe '#inebriated?' do 
      it 'returns true if user has drunk more than 5 beers in an hour' do 
        user = create(:user, recent_beers: 5, last_beer: DateTime.now)

        expect(user.inebriated?).to eq(true)
        expect(user.recent_beers).to eq(6)
      end

      it 'returns false if user has drunk less than 5 beers in an hour' do 
        user = create(:user, recent_beers: 3, last_beer: DateTime.now)

        expect(user.inebriated?).to eq(false)
        expect(user.recent_beers).to eq(4)
      end

      it 'returns false and resets beer counter if last beer was over an hour ago' do 
        user = create(:user, recent_beers: 3, last_beer: DateTime.now - 1.0)

        expect(user.inebriated?).to eq(false)
        expect(user.recent_beers).to eq(1)
      end
    end
  end
end