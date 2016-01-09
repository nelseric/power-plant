Hasu.load("circle.rb")

class Node

	attr_accessor :x, :y, :map, :scale_x, :scale_y, :size, :connectors

	def initialize( pos: {x: 0, y: 0}, scale: {x: 1.0, y: 1.0} , map: nil, size: 16)
		@x = pos[:x]
		@y = pos[:y]
		@map = map

		@size = size

		@connectors = []
	end

	def install_connector connector
		@connectors << connector
	end

	def draw(window, scale_x, scale_y)
		@image ||= Gosu::Image.new(window, Circle.new(20), false)

		@scale_x = scale_x
		@scale_y = scale_y

		window.draw_quad(
				scaled_x - size / 2, scaled_y - size / 2, color,
				scaled_x + size / 2, scaled_y - size / 2, color,
				scaled_x - size / 2, scaled_y + size / 2, color,
				scaled_x + size / 2, scaled_y + size / 2, color, 0
			)
	end

	def color
		Gosu::Color::RED
	end

	def scaled_x
		scale_x * x
	end

	def scaled_y
		scale_y * y
	end

	def intersect?(p_x, p_y)
		Gosu.distance(scaled_x, scaled_y, p_x, p_y) <= size
	end

	def update map

	end
end
