class Battle < ApplicationRecord
  belongs_to :attacker, class_name: 'Profile'
  belongs_to :defender, class_name: 'Profile'
  belongs_to :winner, class_name: 'Profile'

  validates :battle_log, presence: true
  validate :winner_must_be_a_participant

  private

  def winner_must_be_a_participant
    return if winner.blank?
    if winner != attacker && winner != defender
      errors.add(:winner, "must be either the attacker or the defender")
    end
  end
end
