Hasu.load 'node.rb'

class ConsumerNode < Node

	attr_accessor :capacity, :value

	def initialize(capacity: 100000.0, value: 0.0, **args)
		super(**args)

		@capacity = capacity
		@value = value
	end

	def color
		Gosu::Color::GREEN
	end
	def empty_color
		Gosu::Color::RED
	end

	def pressure
		value / capacity
	end

	def consumption
		rand(0..20)
	end

	def inflow
		if connectors.count >= 1
			flows = connectors.map do |connector|
				if connector.a == self
					-connector.flow
				else # we are b, so we have to invert the flow
					connector.flow
				end
			end
			flows.inject :+
		else
			0.0
		end
	end

	def update map
		@value = [[@value + (inflow) - consumption , 0.0].max, capacity].min
	end

	def draw window, scale_x, scale_y
		super window, scale_x, scale_y

		fill = (0.5 - value / capacity) * size

		window.draw_quad(
				scaled_x - size / 2, scaled_y - size / 2, empty_color,
				scaled_x + size / 2, scaled_y - size / 2, empty_color,
				scaled_x - size / 2, scaled_y + fill, empty_color,
				scaled_x + size / 2, scaled_y + fill, empty_color, 1
			)
	end

end
