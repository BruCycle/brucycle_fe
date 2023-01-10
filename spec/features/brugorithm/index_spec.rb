require 'rails_helper'

RSpec.describe 'brugorithm page' do 
  before :each do 
    visit '/brugorithm'
  end
  describe 'contents' do 
    it 'displays the brugorithm to the user' do 
      save_and_open_page
    end
  end
end