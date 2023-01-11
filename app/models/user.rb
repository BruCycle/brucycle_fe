class User < ApplicationRecord
  def inebriated?
    # Adds beer to recent beers if users last beer was less than an hour ago
    if last_beer && last_beer > one_hour_ago
      add_to_recent_beers
      # Returns true if user had more than 4 beers in the last hour
      if recent_beers > 4
        return true
      end
    # Resets beer count to 1 and the Date last beer was drunk if the last beer was more than an hour ago
    else
      reset_recent_beers
    end
    false
  end

  def add_to_recent_beers
    update(recent_beers: recent_beers + 1)
  end

  def reset_recent_beers
    update(recent_beers: 1, last_beer: DateTime.now)
  end

  def one_hour_ago
    (DateTime.now - 1.0 / 24)
  end
end