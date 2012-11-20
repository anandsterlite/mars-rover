#Class dedicated for handling player options at console

require File.expand_path(File.dirname(__FILE__) + '/game')
class Player
 
 # User starts palying game from here
 def self.play 
  option = ''
  while ! ['exit', 'quit', 'x', 'q', '3'].include? option
    print "\n"
    puts '1 - new game', '2 - add rover', "3 - quit"
    print "INPUT : "
    option = gets.chop
    case option
      when '1', 'new game', 's'
        game = Game.new
        game.start
      when '2', 'add rover', 'next', 'n'
        unless game
          game = Game.new
          game.start
          next
        end
        game.add_new_rover
    end
  end
 end
 
 self.play
  
end
