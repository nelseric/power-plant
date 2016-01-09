Hasu.load 'map.rb'
Hasu.load 'resource_node.rb'
Hasu.load 'consumer_node.rb'
Hasu.load 'connector.rb'

class MapGenerator
  attr_reader :map

  def self.generate_map(seed, resource_count: 10, consumer_count: 3)
  	gen = new seed: seed
  	gen.seed_node resource_count, ResourceNode
  	gen.seed_node consumer_count,  ConsumerNode

  	gen.map << Connector.new(*gen.map.nodes.sample(2))
  	gen.map
  end

  def initialize(seed:nil)
    @seed = seed

    @map = Map.new seed: seed
  end

  def seed_node(count, klass)
  	count.times do
  		@map << klass.new(pos: map.random_position, capacity: 1000, value: rand(0..1000))
  	end
  end
end
