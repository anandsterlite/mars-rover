#2D concrete mat
module Mat_2d
  #sets concrete mat
  def set_mat
    mat_size
    mat_set
  end
   
  #mat size input
  def mat_size
    while @x == 0
      print "\nRows : "
      input = gets.chop
      begin
        @x = input.to_i
      rescue
      end
    end
    while @y == 0
      print "\nColumns : "
      input = gets.chop
      begin
        @y = input.to_i
      rescue
      end
    end
  end
  
  def mat_set
    @mat = Array.new
    @x.times{ |r|
        @y.times{|c| 
          @mat[r] = Array.new
        }
    } 
  end
  
  def add_rover
    new_rover = nil
    x,y = 0
    until new_rover
      print "\nAdd rover position : "
      input = gets.chop
      begin
        pos = input.split
        if pos.size == 3
          new_rover = Rover.new(pos[2])
          x = pos[0].to_i 
          y = pos[1].to_i
        end
      rescue
      end
    end 
    if x < @x && y < @y
      @mat[x][y] = new_rover
    end
    return x,y
  end
  
  def rover_msg
    msg = nil
    until msg
      print "\nRover msg : "
      input = gets.chop
      begin
        if input.length > 0 && input =~ /^(L|R|M)*$/
           msg = input
        end
      rescue
      end
    end    
    msg
  end
  
  def move_rover x, y, msg
    msg.each_char do |command|
      case command
      when 'L'
          rotate_left @mat[x][y]
      when 'R'
          rotate_right @mat[x][y]
      when 'M'
          x, y = move_foward x, y
     end
    end
  end
  
  def move_foward x, y
   case @mat[x][y].direction
    when 'N'
      if x >= 0 && x < @x && y+1 >= 0 && y+1 < @y && @mat[x][y+1].nil?
        @mat[x][y+1] = @mat[x][y]
        @mat[x][y] = nil
        return x, y+1
      end
    when 'W'
      if x+1 >= 0 && x+1 < @x && y >= 0 && y < @y && @mat[x+1][y].nil?
        @mat[x+1][y] = @mat[x][y]
        @mat[x][y] = nil
        return x+1, y
      end
    when 'S'
      if x >= 0 && x < @x && y-1 >= 0 && y-1 < @y && @mat[x][y-1].nil?
        @mat[x][y-1] = @mat[x][y]
        @mat[x][y] = nil
        return x, y-1
      end
    when 'E'
      if x-1 >= 0 && x-1 < @x && y >= 0 && y < @y && @mat[x-1][y].nil?
        @mat[x-1][y] = @mat[x][y]
        @mat[x][y] = nil
        return x-1, y
      end
   end 
     raise "ROVER STOPED: it leads to clashing with another or out of bound\n"
  end
    
  
  def rotate_left rover
    rover.direction = case rover.direction
    when 'N' then 'W'
    when 'W' then 'S'
    when 'S' then 'E'
    when 'E' then 'N'
    end
  end

  def rotate_right rover
    rover.direction = case rover.direction
    when 'N' then 'E'
    when 'E' then 'S'
    when 'S' then 'W'
    when 'W' then 'N'
    end
  end
  
  #Display mat in user console
  def display
    print "\nCurrent position of added rovers:\n"
    @x.times{ |r|
        @y.times{|c| 
          print "#{r.to_s} #{c.to_s} #{@mat[r][c].direction}\n" if @mat[r][c]
          }
    }
  end  
end
