module Ppson
  class FileArguments < Arguments
    def argument_instance(argument_data, options)
      FileArgument.new(argument_data, options)
    end
  end
end
