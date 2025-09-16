class WorldMonster < ApplicationRecord
  validates :name, :level, :pos_x, :pos_y, :hp, presence: true
  after_update :respawn_if_dead

  def receive_attack(damage)
    self.hp -= damage
    self.save
  end

  def dead?
    hp <= 0
  end

  private

  def respawn_if_dead
    return unless dead?

    map_width = 1920
    map_height = 1080

    padding = 50

    new_pos_x = rand(padding..(map_width - padding))
    new_pos_y = rand(padding..(map_height - padding))

    update(hp: 100, pos_x: new_pos_x, pos_y: new_pos_y)
  end
end
