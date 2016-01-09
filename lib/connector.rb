require 'gosu'

class Connector
	attr_accessor :a, :b, :multiplier

	# multiplier is a measure of pressure drop / distance
	def initialize(node_a, node_b, multiplier: 10000000.0)
		@a = node_a
		@b = node_b

		@multiplier = multiplier

		a.install_connector self
		b.install_connector self
	end

	def length
		Gosu.distance a.x, a.y, b.x, b.y
	end

	def direction
		(a.pressure - b.pressure) / (a.pressure - b.pressure).abs
	end

	def flow
		puts ((a.pressure - b.pressure) * (multiplier / length) )
		((a.pressure - b.pressure) * (multiplier / (length ** 2)) )
	end

	def draw window
		window.draw_line(
			a.scaled_x, a.scaled_y, color,
			b.scaled_x, b.scaled_y, color,
			-1
		)
	end

	def color
		Gosu::Color::YELLOW
	end

end
