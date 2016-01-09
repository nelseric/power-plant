require 'gosu'

class Circle
  attr_reader :columns, :rows
  
  def initialize radius
    @columns = @rows = radius * 2
    lower_half = (0...radius).map do |y|
      x = Math.sqrt(radius**2 - y**2).round
      right_half = "#{"\xff" * x}#{"\x00" * (radius - x)}".b
      "#{right_half.reverse}#{right_half}".b
    end.join
    @blob = (lower_half.reverse + lower_half).b
    @blob.gsub!(/./) { |alpha| "\xff\xff\xff".b + alpha.b}
  end
  
  def to_blob
    @blob
  end
end
