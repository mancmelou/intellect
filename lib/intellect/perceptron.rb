module Intellect
  class Perceptron
    attr_reader :weights, :activation, :learning_rate
    
    def initialize(layers = [], activaton = nil)
      @activation ||= lambda { |x| 1 / (1 + Math.exp(-1 * x)) }
      @weights = generate_weights(layers)
    end
    
    # Belongs to Network
    def train(input, result)
    end
    
    # Belongs to Network
    def eval(input)
    end
    
    def feedforward(input)
      activation.call(input)
    end
    
    private
    
    def generate_weights(layers)
      @weights = layers.inject([]) do |layer, nodes|
        layer << nodes.times.inject([]) { |s, n| s << rand }
      end
    end
  end
end
