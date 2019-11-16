# EXTRA CREDIT:
#
# Create a program that will play the Greed Game.
# Rules for the game are in GREED_RULES.TXT.
#
# You already have a DiceSet class and score function you can use.
# Write a player class and a Game class to complete the project.  This
# is a free form assignment, so approach it however you desire.
require File.expand_path(File.dirname(__FILE__) + '/about_dice_project')
require File.expand_path(File.dirname(__FILE__) + '/about_scoring_project')

class Player
    
    def initialize(name)
        @name = name
        @score = 0
    end

    def current_score
        "#{@name}: #{@score}"
    end

    def roll_dices(dice_set)
        puts "#{@name}. Press any key to roll dices"
        gets
        dices = dice_set.roll(5)
        @score += score(dices)
        puts "Roll dices: #{dices}. Score: #{score(dices)}"
        @score
    end

    def wins()
        puts "#{@name} wins! Score: #{@score}"
        exit
    end
end

class Game
    attr_accessor :players

    def initialize(num_players)
        @dice_set = DiceSet.new
        @players = []
        @current_player = 0
        (0...num_players).each{|i| @players << Player.new("Player #{i + 1}")}
    end

    def current_player()
        @players[@current_player]
    end

    def roll_dices()
        score = self.current_player.roll_dices(@dice_set)
        if score >= 3000
            current_player.wins()
        end
    end

    def next_turn()
        @current_player = (@current_player + 1) % @players.length
    end

    def show_score()
       @players.each{ |player| puts player.current_score}
    end
end

puts "============= GREED GAME ==============="
puts "How many players?"
num_players = gets.chomp.to_i
game = Game.new(num_players)
while true
    game.roll_dices()
    game.next_turn()
    game.show_score()
end
