module Ppson
  class ArgumentsDecorator
    attr_reader :arguments, :options

    def initialize(arguments, options)
      @arguments = arguments
      @options = options
    end

    def decorate
      options[:file] ? file_arguments : json_arguments
    end

    private

    def file_arguments
      FileArguments.new(arguments, options)
    end

    def json_arguments
      JsonArguments.new(arguments, options)
    end
  end
end
