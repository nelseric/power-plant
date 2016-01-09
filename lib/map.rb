Hasu.load "connector.rb"
Hasu.load "node.rb"

class Map

	WIDTH = 1000.0
	HEIGHT = 1000.0

  attr_accessor :nodes, :connectors

  def initialize(seed: Random.new_seed)
  	@rand = Random.new seed
    @nodes = []
    @connectors = []
  end

  def <<(element)
  	if element.kind_of? Node
    	@nodes << element
  	elsif element.kind_of? Connector
  		@connectors << element
  	end
  end

  def random_position
    {
      x: @rand.rand(0..WIDTH),
      y: @rand.rand(0..HEIGHT)
    }
  end

  def update
    nodes.each {|node| node.update self}
  end

  def draw(window)
  	h_scale = window.width / WIDTH
  	v_scale = window.height / HEIGHT

    nodes.each do |node|
      node.draw window, h_scale, v_scale
    end
    connectors.each do |con|
    	con.draw window
    end
  end

  def clicked? pos_x, pos_y
  	nodes.select {|node| node.intersect? pos_x, pos_y}
  end

end
