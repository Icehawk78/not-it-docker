class Trip < ActiveRecord::Base
  belongs_to :group
  has_many :rolls
  has_many :players, through: :rolls
  
  def lowest_rolls
    self.rolls.where("modifier + raw_value = ?", self.rolls.minimum('modifier + raw_value'))
  end

  def highest_rolls
    self.rolls.where("modifier + raw_value = ?", self.rolls.maximum('modifier + raw_value'))
  end
  
  def complete?
    !self.rolls.any? {|r| r.result.nil? }
  end
end
