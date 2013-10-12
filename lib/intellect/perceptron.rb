module Intellect
  class Perceptron
    attr_reader :weights, :activation 
    
    def initialize(layers, options = {})
      @activation = options[:activation] || lambda { |x| 1/(1+Math.exp(-1*(x))) }
      @weights    = generate_weights(layers) || [1]
    end
    
    private
    
    def generate_weight(layers)
      @weights = layers.inject([]) do |layer, nodes|
        layer << nodes.times.inject([]) { |s, n| s << rand }
      end
    end
  end
end
