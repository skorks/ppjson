module Ppson
  class FileArgument
    attr_reader :filepath, :options

    def initialize(filepath, options)
      @filepath = filepath
      @options = options
    end

    def process
      with_contents do |contents|
        writer.write(contents, :pretty => prettify?)
      end
    end

    private

    def with_contents(&block)
      contents = reader.read
      block.call(contents) if contents
    end

    def reader
      @reader ||= FileJsonReader.new(filepath)
    end

    def writer
      @writer ||= (options[:inline] ? FileJsonWriter.new(filepath) : StdoutJsonWriter.new)
    end

    def prettify?
      !options[:undo]
    end
  end
end
