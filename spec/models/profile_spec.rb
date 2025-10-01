require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'associations' do
    it 'belongs to user' do
      expect(Profile.reflect_on_association(:user).macro).to eq(:belongs_to)
    end 

    it 'belongs to map_plot' do
      expect(Profile.reflect_on_association(:map_plot).macro).to eq(:belongs_to)
    end

    it 'map_plot is optional' do
      association = Profile.reflect_on_association(:map_plot)
      expect(association.options[:optional]).to be(true)
    end

    it 'has one guild membership' do
      expect(Profile.reflect_on_association(:guild_membership).macro).to eq(:has_one)
    end

    it 'guild membership dependent destroy' do
      association = Profile.reflect_on_association(:guild_membership)
      expect(association.options[:dependent]).to eq(:destroy)
    end

    it 'has one guild' do
      expect(Profile.reflect_on_association(:guild).macro).to eq(:has_one)
    end

    it 'has one guild through guild membership' do
      association = Profile.reflect_on_association(:guild)
      expect(association.options[:through]).to eq(:guild_membership)
    end

    it 'has many buildings' do
      expect(Profile.reflect_on_association(:buildings).macro).to eq(:has_many)
    end

    it 'buildings dependent destroy' do
      association = Profile.reflect_on_association(:buildings)
      expect(association.options[:dependent]).to eq(:destroy)
    end

    it 'has many equipments' do
      expect(Profile.reflect_on_association(:equipments).macro).to eq(:has_many)
    end

    it 'equipment dependent destroy' do
      association = Profile.reflect_on_association(:equipments)
      expect(association.options[:dependent]).to eq(:destroy)
    end

    it 'has many equipment items' do
      expect(Profile.reflect_on_association(:equipment_items).macro).to eq(:has_many)
    end

    it 'has many equipment items through equipments' do
      association = Profile.reflect_on_association(:equipment_items)
      expect(association.options[:through]).to eq(:equipments)
    end

    it 'has many troops' do
      expect(Profile.reflect_on_association(:troops).macro).to eq(:has_many)
    end

    it 'has many troops through buildings' do
      association = Profile.reflect_on_association(:troops)
      expect(association.options[:through]).to eq(:buildings)
    end

    it 'has many attacking battles' do
      expect(Profile.reflect_on_association(:attacking_battles).macro).to eq(:has_many)
    end

    it 'attacking battles has a class name' do
      association = Profile.reflect_on_association(:attacking_battles)
      expect(association.options[:class_name]).to eq('Battle')
    end

    it 'attacking battles has a foreing key' do
      association = Profile.reflect_on_association(:attacking_battles)
      expect(association.options[:foreign_key]).to eq(:attacker_id)
    end

    it 'attacking battles dependent destroy' do
      association = Profile.reflect_on_association(:attacking_battles)
      expect(association.options[:dependent]).to eq(:nullify)
    end

    it 'has many defending battles' do
      expect(Profile.reflect_on_association(:defending_battles).macro).to eq(:has_many)
    end

    it 'defending battles has a class name' do
      association = Profile.reflect_on_association(:defending_battles)
      expect(association.options[:class_name]).to eq('Battle')
    end

    it 'defending battles has a foreing key' do
      association = Profile.reflect_on_association(:defending_battles)
      expect(association.options[:foreign_key]).to eq(:defender_id)
    end

    it 'defending battles dependent destroy' do
      association = Profile.reflect_on_association(:defending_battles)
      expect(association.options[:dependent]).to eq(:nullify)
    end

    it 'has many won battles' do
      expect(Profile.reflect_on_association(:won_battles).macro).to eq(:has_many)
    end

    it 'won battles has a class name' do
      association = Profile.reflect_on_association(:won_battles)
      expect(association.options[:class_name]).to eq('Battle')
    end

    it 'won battles has a foreing key' do
      association = Profile.reflect_on_association(:won_battles)
      expect(association.options[:foreign_key]).to eq(:winner_id)
    end

    it 'won battles dependent destroy' do
      association = Profile.reflect_on_association(:won_battles)
      expect(association.options[:dependent]).to eq(:nullify)
    end
  end
end
