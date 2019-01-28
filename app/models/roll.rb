class Roll < ActiveRecord::Base
  belongs_to :trip
  belongs_to :player_group
  delegate :player, to: :player_group
  delegate :group, to: :player_group

  def result
    (self.raw_value.nil? or self.modifier.nil?) ? nil : self.raw_value + self.modifier
  end
end
