class Group < ActiveRecord::Base
  has_many :player_groups
  has_many :players, through: :player_group
  has_many :trips

  def min_other_bank player_group
    (self.player_groups - [player_group]).inject(20){|min, pg| pg.bank < min ? pg.bank : min}
  end
end
