module Intellect
  class Network
    attr_reader :network
    
    def initialize(layers = [], opts = {})
      @network = []
      
      layers.each do |n|
        @network << n.times.reduce([]) { |sum, i| sum + Perceptron.new(i) }
      end
    end
    
    private
    
    def generate_weights!(layers)
      @weights = layers.inject([]) do |layer, nodes|
        layer << nodes.times.inject([]) { |s, n| s << rand }
      end
    end
  end
  
  class Perceptron
    attr_reader :weights, :activate
    
    def initialize(n_inputs, activation = nil)
      @activate = activation || lambda { |x| 1 / (1 + Math.exp(-1 * x)) }
      @weights  = generate_weights(n_inputs)
    end
    
    def feedforward(input = [])
      sum = 0
      
      input.each_with_index do |n, i|
        sum += n * weights[i]
      end
      
      activate.call(sum)
    end
    
    private
    
    def generate_weights(n_inputs)
      n_inputs.times.reduce([]) { |sum, n| sum << rand }
    end
  end
end
