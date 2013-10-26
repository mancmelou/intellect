module Intellect
  InputSizeError = Class.new(RuntimeError)
    
  class Network
    attr_reader :network, :n_inputs, :n_outputs, :layers
    
    def initialize(topology = [], opts = {})
      @network = []
      
      n_inputs, *layers, n_outputs = topology
      
      layers.each do |n|
        @network << n.times.reduce([]) { |sum, i| sum << Perceptron.new(n) }
      end
    end
    
    def eval(input = [])
      raise InputSizeError if input.size != n_inputs
      
      output = input.clone
      
      network.each do |layer|
        output = layer.reduce([]) { |sum, n| sum << n.feedforward(output) }
      end
      
      output
    end
  end
  
  class Perceptron
    attr_reader :weights, :activate
    
    def initialize(n_inputs, activation = nil)
      @activate = activation || lambda { |x| 1 / (1 + Math.exp(-1 * x)) }
      @weights  = generate_weights(n_inputs)
    end
    
    def feedforward(input = [])
      raise InputSizeError unless input.size == weights.size
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
