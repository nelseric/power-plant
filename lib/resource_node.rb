Hasu.load 'node.rb'

require 'pry'
class ResourceNode < Node
	attr_accessor :capacity, :value

	def initialize(capacity: 10000.0, value: 10000.0, **args)
		super(**args)

		@capacity = capacity
		@value = value

		@connectors = []
	end

	def install_connector connector
		@connectors << connector
	end

	def pressure
		value / capacity
	end

	def outflow
		if connectors.count >= 1
			flows = connectors.map do |connector|
				if connector.a == self
					connector.flow
				else # we are b, so we have to invert the flow
					-connector.flow
				end
			end
			flows.inject :+
		else
			0.0
		end
	end

	def update map
		# binding.pry if connectors.count >= 1 and outflow != 0.0

		@value = [[production + @value - (outflow) , 0.0].max, capacity].min
	end

	def production
		rand(0..10)
	end

	def percentage_full
		(value / capacity)
	end

	def color
		Gosu::Color::BLUE
	end

	def empty_color
		Gosu::Color::RED
	end

	def draw window, scale_x, scale_y
		super window, scale_x, scale_y

		fill = (0.5 - percentage_full) * size

		window.draw_quad(
				scaled_x - size / 2, scaled_y - size / 2, empty_color,
				scaled_x + size / 2, scaled_y - size / 2, empty_color,
				scaled_x - size / 2, scaled_y + fill, empty_color,
				scaled_x + size / 2, scaled_y + fill, empty_color, 1
			)
	end
end
