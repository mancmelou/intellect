module Intellect
  class Perceptron
    attr_reader :inputs, :weights, :activation 
    
    def initialize(topology = [], options = {})
      @inputs     = topology.first || 1
      @activation = options[:activation] || lambda { |x| 1/(1+Math.exp(-1*(x))) }
      
      @weights = generate_weights(topology) || [1]
    end
    
    private 
    
    def generate_weights(topology)
      @weights = topology.inject([]) do |layer, nodes|
        layer << nodes.times.inject([]) { |s, n| s << rand }
      end
    end
  end
end
