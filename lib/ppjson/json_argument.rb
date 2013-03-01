module Ppson
  class JsonArgument
    attr_reader :data, :options

    def initialize(data, options)
      @data = data
      @options = options
    end

    def process
      Ppjson::StreamJsonWriter.new.write(data, :pretty => true)
    end
  end
end
