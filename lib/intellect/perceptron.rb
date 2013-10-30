module Intellect
  IntellectError = Class.new(RuntimeError)
  InputSizeError = Class.new(IntellectError)
    
  class Network
    attr_reader :network, :layers, :n_inputs, :n_outputs
    
    def initialize(layers = [], opts = {})
      @network    = []
      @n_inputs   = layers.first
      @n_outputs  = layers.last

      activation = opts[:activation]

      layers.each_index do |i|
        if i == 0
          inputs = layers.first
        else 
          inputs = layers[i-1]
        end
        @network << layers[i].times.reduce([]) { |sum, i| sum << Perceptron.new(inputs, activation) }
      end
    end
    
    def eval(input = [])
      raise InputSizeError, "Number of inputs was #{input.size} (expected #{n_inputs})" if 
        input.size != n_inputs
      
      output = input.clone
      
      network.each_with_index do |layer, i|
        output = layer.reduce([]) { |sum, n| sum << n.feedforward(output) }

        puts "Layer #{i+1} forwarded #{output}"
        puts "+" * 100
      end
      
      output
    end

    def train(input, expected)
      result = eval(input)
      error  = expected - result
      
      backpropagate(error)
    end
    
    def inspect
      "== n_inputs=#{n_inputs} n_outputs=#{n_outputs} layers=#{layers} == \n" + super
    end
    
    private 
    
    def backpropagate(error)
    end
  end
  
  class Perceptron
    BIAS = 1.0

    attr_reader :weights, :activate, :bias_weight
    
    def initialize(n_inputs, activation = nil)
      @activate    = activation || lambda { |x| 1 / (1 + Math.exp(-1 * x)) }
      @weights     = generate_weights(n_inputs)
      @bias_weight = rand * sign
    end
    
    def feedforward(input = [])
      raise InputSizeError, "Number of input values was #{input.size} (expected #{weights.size})" if 
        input.size != weights.size
      
      sum = 0
      
      input.each_with_index do |n, i|
        sum += n * weights[i]
      end

      sum += BIAS * bias_weight
      
      activate.call(sum)
    end
    
    private
    
    def generate_weights(n_inputs)
      n_inputs.times.reduce([]) { |sum, n| sum << (rand * sign) }
    end

    def sign
      [-1, 1].sample
    end
  end
end
