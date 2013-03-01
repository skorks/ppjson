module Ppson
  class Arguments
    include Enumerable

    attr_reader :arguments, :options

    def initialize(arguments, options)
      @arguments = arguments
      @options = options
    end

    def each(&block)
      arguments.each do |argument|
        block.call(argument_instance(argument, options))
      end
    end

    def argument_instance(argument_data, options)
      raise "Must be implemented in child class"
    end
  end
end
