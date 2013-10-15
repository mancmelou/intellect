module Intellect
  class Perceptron
    attr_reader :weights, :activation, :learning_rate
    
    def initialize(layers = [], activaton = nil)
      @activation ||= lambda { |x| 1/(1+Math.exp(-1*(x))) }
      @weights = generate_weights(layers.size)
    end
    
    def train(input, result)
    end
    
    def eval(input)
    end
    
    def feedforward(input) 
    end
    
    private
    
    def generate_weights(size)
      @weights = layers.inject([]) do |layer, nodes|
        layer << nodes.times.inject([]) { |s, n| s << rand }
      end
    end
  end
end
