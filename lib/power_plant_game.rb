require 'hasu'

Hasu.load "map_generator.rb"
Hasu.load 'player.rb'

class PowerPlantGame < Hasu::Window
  WIDTH = 1024
  HEIGHT = 768

  attr_reader :width, :height, :fullscreen

  def initialize(width: WIDTH, height: HEIGHT, fullscreen: false)
    super(width, height, fullscreen)
    @width =  width
    @height = height
    @fullscreen = fullscreen
  end

  def reset
    @map = MapGenerator.generate_map seed
    @player = Player.new @map
  end

  def update
  	@player.update mouse_x, mouse_y, button_down?(Gosu::MsRight), button_down?(Gosu::MsLeft), @map
    @map.update
  end

  def button_down(id)
    case id
    when Gosu::KbEscape
      close
    when Gosu::KbS
    	@seed = Random.new_seed
    when Gosu::MsLeft
    	@player.click @map.clicked?(mouse_x, mouse_y).first
    end
  end

  def draw
  	@map.draw self
  	@player.draw self
  end

  def seed
    @seed ||= 0xDEADBEEF
  end

end
