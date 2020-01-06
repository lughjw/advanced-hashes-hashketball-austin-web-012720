# Write your code here!
def game_hash
  game_data = {
    :home => {},
    :away => {}
  }
  
  game_data[:home] = create_team("Brooklyn Nets", ["Black","White"])
  game_data[:away] = create_team("Charlotte Hornets", ["Turquoise","Purple"])
  
  game_data[:home][:players] = [
    create_player("Alan Anderson",  0, 16, 22, 12, 12,  3,  1,  1),
    create_player("Reggie Evans",  30, 14, 12, 12, 12, 12, 12,  7),
    create_player("Brook Lopez",   11, 17, 17, 19, 10,  3,  1, 15),
    create_player("Mason Plumlee",  1, 19, 26, 11,  6,  3,  8,  5),
    create_player("Jason Terry",   31, 15, 19,  2,  2,  4, 11,  1)
  ]
  
  game_data[:away][:players] = [
    create_player("Jeff Adrien",     4, 18, 10,  1,  1,  2,  7,  2),
    create_player("Bismack Biyombo", 0, 16, 12,  4,  7, 22, 15, 10),
    create_player("DeSagna Diop",    2, 14, 24, 12, 12,  4,  5,  5),
    create_player("Ben Gordon",      8, 15, 33,  3,  2,  1,  1,  0),
    create_player("Kemba Walker",   33, 15,  6, 12, 12,  7,  5, 12)
  ]
  
  game_data
end

def create_team(team_name, colors)
  {
    :team_name => team_name,
    :colors => [colors[0],colors[1]],
    :players => []
  }
end

def create_player(player_name, number, shoe_size, points, rebounds, assists, steals, blocks, slam_dunks)
  {
    :player_name => player_name,
    :number      => number,
    :shoe        => shoe_size,
    :points      => points,
    :rebounds    => rebounds,
    :assists     => assists,
    :steals      => steals,
    :blocks      => blocks,
    :slam_dunks  => slam_dunks
  }
end

def num_points_scored(player_name)
  player = get_player_by_name(player_name)
  if player == nil
    return 0 
  end
    
  player[:points]
end

def shoe_size(player_name)
  player = get_player_by_name(player_name)
  if player == nil
    return 0 
  end
  
  player[:shoe]
end

def team_colors(team_name)
  team = get_team_by_name(team_name)
  
  team[:colors]
end

def team_names
  game_hash.map {|k,v| v[:team_name]}
end

def player_numbers(team_name)
  team = get_team_by_name(team_name)
  team[:players].map{|player| player[:number]}
end

def player_stats(player_name)
  player = get_player_by_name(player_name)
  
  player.reject{|k,v| v == player_name}
end

def big_shoe_rebounds
  
  players = []
  game_hash.each_pair do |k,team|
    players += team[:players]
  end
  
  big_shoe = players.map{|player| player[:shoe]}.max
  
  big_rebounds = players.select{|player| player[:shoe] == big_shoe}[0]
  
  big_rebounds[:rebounds]
end

def most_points_scored
  players = []
  game_hash.each_pair do |k,team|
    players += team[:players]
  end
  
  most_points = players.map{|player| player[:points]}.max
  
  players.select{|player| player[:points] == most_points}[0][:player_name]
end

def winning_team
  home_points = game_hash[:home][:players].inject(0){|sum, player| sum + player[:points]}
  away_points = game_hash[:away][:players].inject(0){|sum, player| sum + player[:points]}
  
  winner = home_points > away_points ? :home : :away
  
  game_hash[winner][:team_name]
end

def player_with_longest_name
  long_name = ""
  game_hash.each_pair{|k,team| 
    team[:players].each{|player| 
      if player[:player_name].size > long_name.size
        long_name = player[:player_name]
      end
    }
  }
  
  long_name
end

def long_name_steals_a_ton?
  players = []
  game_hash.each_pair do |k,team|
    players += team[:players]
  end
  
  most_steals = players.map{|player| player[:steals]}.max
  
  steal_player = players.select{|player| player[:steals] == most_steals}[0][:player_name]
  
  steal_player == player_with_longest_name
end

def get_team_by_name(team_name)
  team = {}
  game_hash.each_pair do |k1,v1|
    if v1[:team_name] == team_name
      team = v1
      break
    end
  end
  
  team
end

def get_player_by_name(player_name)
  result = []
  game_hash.each_pair do |k1,v1|
    result = v1[:players].select{|player| player[:player_name] == player_name}
    
    if not result.empty?
      break
    end
  end
  
  result[0]
end
  #   :home => {
  #     :team_name => "",
  #     :colors    => ["",""],
  #     :players   => [{
  #       :player_name => "",
  #       :number      => 0,
  #       :shoe        => 0,
  #       :points      => 0,
  #       :rebounds    => 0,
  #       :assists     => 0,
  #       :steals      => 0,
  #       :blocks      => 0,
  #     :slam_dunks  => 0
  #     }]
  #   },
  #   :away => {
  #     :team_name => "",
  #     :colors    => ["",""],
  #     :players   => [{
  #       :player_name => "",
  #       :number      => 0,
  #       :shoe        => 0,
  #       :points      => 0,
  #       :rebounds    => 0,
  #       :assists     => 0,
  #       :steals      => 0,
  #       :blocks      => 0,
  #       :slam_dunks  => 0
  #     }]
  #   }
  # }






