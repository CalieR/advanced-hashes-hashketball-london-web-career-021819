require 'pry'

# TO DO: refactor these methods to make more usable and less verbose

def game_hash
  teams = {
    :home => {
      :team_name => "Brooklyn Nets",
      :colors => ["Black", "White"],
      :players => {
        "Alan Anderson" => {
          :number => 0,
          :shoe => 16,
          :points => 22,
          :rebounds => 12,
          :assists => 12,
          :steals => 3,
          :blocks => 1,
          :slam_dunks => 1
        },
        "Reggie Evans" => {
          :number => 30,
          :shoe => 14,
          :points => 12,
          :rebounds => 12,
          :assists => 12,
          :steals => 12,
          :blocks => 12,
          :slam_dunks => 7
        },
        "Brook Lopez" => {
          :number => 11,
          :shoe => 17,
          :points => 17,
          :rebounds => 19,
          :assists => 10,
          :steals => 3,
          :blocks => 1,
          :slam_dunks => 15
        },
        "Mason Plumlee" => {
          :number => 1,
          :shoe => 19,
          :points => 26,
          :rebounds => 12,
          :assists => 6,
          :steals => 3,
          :blocks => 8,
          :slam_dunks => 5
        },
        "Jason Terry" => {
          :number => 31,
          :shoe => 15,
          :points => 19,
          :rebounds => 2,
          :assists => 2,
          :steals => 4,
          :blocks => 11,
          :slam_dunks => 1
        }
      }
    },
    :away => {
      :team_name => "Charlotte Hornets",
      :colors => ["Turquoise", "Purple"],
      :players => {
        "Jeff Adrien" => {
          :number => 4,
          :shoe => 18,
          :points => 10,
          :rebounds => 1,
          :assists => 1,
          :steals => 2,
          :blocks => 7,
          :slam_dunks => 2
        },
        "Bismak Biyombo" => {
          :number => 0,
          :shoe => 16,
          :points => 12,
          :rebounds => 4,
          :assists => 7,
          :steals => 7,
          :blocks => 15,
          :slam_dunks => 10
        },
        "DeSagna Diop" => {
          :number => 2,
          :shoe => 14,
          :points => 24,
          :rebounds => 12,
          :assists => 12,
          :steals => 4,
          :blocks => 5,
          :slam_dunks => 5
        },
        "Ben Gordon" => {
          :number => 8,
          :shoe => 15,
          :points => 33,
          :rebounds => 3,
          :assists => 2,
          :steals => 1,
          :blocks => 1,
          :slam_dunks => 0
        },
        "Brendan Haywood" => {
          :number => 33,
          :shoe => 15,
          :points => 6,
          :rebounds => 12,
          :assists => 12,
          :steals => 22,
          :blocks => 5,
          :slam_dunks => 12
        }
      }
    }
  }
end

def num_points_scored(player)
  player_stats(player)[:points]
end

def shoe_size(player)
  player_stats(player)[:shoe]
end

def team_colors(team)
  game_hash.each do |location, team_info|
    team_info.each do |k, v| # iterating the same hash twice:
      if v == team # once we have identified the desired team...
        team_info.each do |k, v|
          if k == :colors # ...we can identify the desired hash and return its value
            return v
          end
        end
      end
    end
  end
end

def team_names
  team_array = []
  team_array << game_hash[:home][:team_name]
  team_array << game_hash[:away][:team_name]
  return team_array
end

def player_numbers(team)
  result = []
  game_hash.each do |location, team_info|
    team_info.each do |k, v|
      if v == team # locate desired team
        team_info.each do |x, y| # y is each player hash
          if x == :players
            y.each do |player_name, stats| # iterate each player hash
              stats.each do |stat, val|
                if stat == :number
                  result << val
                end
              end
            end
          end
        end
      end
    end
  end
  return result
end

def player_stats(player) # using this method as a helper enabled me to refactor several other methods
  game_hash.each do |location, team_info|
    team_info.each do |k, v|
      if k == :players
        v.each do |name, stats|
          if name == player
            return stats
          end
        end
      end
    end
  end
end

def all_players # returns a hash containing stats for every player
  game_hash[:home][:players].merge(game_hash[:away][:players])
end

def big_shoe_rebounds
  # find the biggest shoe size
  shoes = []
  all_players.each do |k, v|
    v.each do |a, b|
      if a == :shoe
        shoes << b
      end
    end
  end
  biggest = shoes.max # 19 - Mason Plumlee

  # find the player with biggest shoe size
  big_foot = ""
   game_hash.each do |location, team_info|
      team_info.each do |x, y|
        if x == :players
          y.each do |player_name, stats|
            stats.each do |j, k|
              if j == :shoe
                if k == biggest
                  big_foot = player_name
                end
              end
            end
          end
        end
      end
   end

  # find that players number of rebounds
  player_stats(big_foot)[:rebounds]
end

def most_points_scored
  # find the highest number of points
  points = []
  all_players.each do |k, v|
    v.each do |a, b|
      if a == :points
        points << b
      end
    end
  end
  best_score = points.max # 33 - Ben Gordon

  # use the highest number of points to find the matching player
  highest_scorer = ""
  all_players.each do |x, y|
    y.each do |a, b|
      if a == :points
        if b == best_score
         highest_scorer = x
        end
      end
     end
   end

   highest_scorer

end
