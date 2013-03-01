module Ppson
  class FileJsonWriter
    attr_reader :filepath

    def initialize(filepath)
      @filepath = filepath
    end

    def write(contents, options = {:pretty => false})
      begin
        File.open(filepath, 'w') do |file|
          Ppjson::StreamJsonWriter.new(file).write(contents, :pretty => options[:pretty])
        end
      rescue => e
        Escort::Logger.error.warn("Error writing file #{filepath}")
      end
    end
  end
end
