require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it 'has one profile' do
      expect(User.reflect_on_association(:profile).macro).to eq(:has_one)
    end
  end

  describe '#create_user_profile' do
    let!(:empty_map_plot) { create(:map_plot) }
    let!(:central_plot) { create(:plot, name: 'Plot 1') }

    context 'when a new user is created' do
      it 'creates a profile for the user' do
        user = create(:user)
        expect(user.profile).to be_present
        expected_username = "#{user.email.split('@').first.gsub(/[^a-zA-Z0-9]/, '')}-#{user.id}"
        expect(user.profile.username).to eq(expected_username)
      end

      it 'assigns an empty MapPlot to the new profile' do
        user = create(:user)
        expect(user.profile.map_plot).to eq(empty_map_plot)
        expect(empty_map_plot.reload.profile).to eq(user.profile)
      end

      it 'creates a level 1 castle for the new profile on Plot 1' do
        user = create(:user)
        expect(user.profile.buildings.count).to eq(1)

        castle = user.profile.buildings.first

        expect(castle.building_type).to eq('castle')
        expect(castle.level).to eq(1)

        expect(castle.plot).to eq(central_plot)
      end
    end
  end
end
