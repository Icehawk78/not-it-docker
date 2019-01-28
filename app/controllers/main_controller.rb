class MainController < ApplicationController

  def index
    @groups = Group.all
    @last_trip = Trip.last
  end

  def create_trip
    @trip = Trip.create(trip_params)
    @trip.group.player_groups.each do |pg|
      Roll.create(trip: @trip, player_group: pg)
    end
    redirect_to action: 'show', id: @trip.group.id
  end

  def valid_rolls rolls
    invalid = rolls.any? do |id, mod|
      mod.nil? or mod < -20 or mod > Roll.find(id).player_group.bank
    end
    unless invalid
      values = rolls.values
      invalid = (values.max - values.min) > 20
    end
    !invalid
  end

  def do_roll
    trip = nil
    rolls = Hash[*params[:rolls].map do |id, roll|
      sign = roll[:action] == 'action-volunteer' ? -1 : 1
      mod = roll[:mod]
      [id, (mod.nil? or mod.empty? or mod.to_i < 0) ? nil : mod.to_i * sign]
    end.flatten]
    group = Roll.find(rolls.keys.first).group

    if valid_rolls(rolls)
      rolls = rebalance(rolls)
      rolls.sort_by{|id, mod| -(mod.to_i)}.each do |id, mod|
        mod = mod.to_i
        roll = Roll.find(id)
        group = roll.group
        trip = roll.trip
        roll.modifier = mod
        roll.raw_value = rand(20) + 1
        roll.save
        # if mod < 0
        #   min_bank = roll.group.min_other_bank roll.player_group
        #   mod += min_bank
        #   (roll.group.player_groups - [roll.player_group]).each do |pg|
        #     pg.bank -= min_bank
        #     pg.save
        #   end
        # end
        roll.player_group.bank -= mod
        roll.player_group.save
      end
      if trip.lowest_rolls.size > 1
        loser = trip.lowest_rolls.sample
        loser.raw_value -= 1
        loser.save
      end
      if trip.highest_rolls.size > 1
        winner = trip.highest_rolls.sample
        winner.raw_value += 1
        winner.save
      end
      # Give a free bank point to the loser if they didn't volunteer
      loser = trip.lowest_rolls.first
      if loser.modifier >= 0
        loser.player_group.bank += 1
        loser.player_group.save
      end
    end
    redirect_to action: 'show', id: group.id
  end

  def show
    @group = Group.find(params[:id])
  end

  private

    def trip_params
      params.require(:trip).permit(:group_id, :description)
    end

    def rebalance(rolls)
      mods = rolls.values
      if mods.min * mods.max > 0
        direction = (mods.min > 0 ? 1 : -1)
        balance = mods.map{|v| v * direction}.min
        rolls = Hash[*rolls.map {|id, mod|
          [id, mod - balance * direction]
        }.flatten]
      end
      rolls
    end
end
