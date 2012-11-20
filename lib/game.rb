#Facade class for entire game

require File.expand_path(File.dirname(__FILE__) + '/rover')
Dir[File.expand_path(File.dirname(__FILE__)) + '/mats/*.rb'].each {|f| require f}
class Game
  @mat
  def initialize dimension = 2
    @x = 0
    @y = 0
    Game.module_eval { include Kernel.const_get "Mat_#{dimension.to_s}d" }
  end
  
  #initiate game for users
  def start
    set_mat
    add_new_rover
  end
  
  #Move the game to consecutive generations
  def add_new_rover
    begin
    x,y = add_rover
    msg = rover_msg
    move_rover x, y, msg
    display
    rescue Exception => e
      print e.message
      display
    end
  end

end