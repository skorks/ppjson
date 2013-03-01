module Ppson
  class JsonArguments < Arguments
    def argument_instance(argument_data, options)
      JsonArgument.new(argument_data, options)
    end
  end
end
