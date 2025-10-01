require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it 'has one profile' do
      expect(User.reflect_on_association(:profile).macro).to eq(:has_one)
    end
  end
end
