Hasu.load 'connector.rb'
class Player

  attr_accessor :x, :y, :target

  alias :scaled_x :x
  alias :scaled_y :y

  def color
    Gosu::Color::WHITE
  end

  def initialize map
    @map = map
  end

  def update x, y, left, right, map
    @x = x
    @y = y
  end

  def draw(window)
    window.draw_quad(
      x-1, y-1, color,
      x+1, y-1, color,
      x-1, y+1, color,
      x+1, y+1, color
    )
    if target
      window.draw_line(
        x, y, color,
        target.scaled_x, target.scaled_y, color,
        -1
      )
    end
  end

  def click node
  	if node
      if @target.nil?
        @target = node
      else
        @map << Connector.new(@target, node)
        @target = nil
      end
    end
  end
end
