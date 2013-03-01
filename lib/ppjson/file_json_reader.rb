module Ppson
  class FileJsonReader
    attr_reader :filepath

    def initialize(filepath)
      @filepath = filepath
    end

    def read
      contents = nil
      begin
        File.open(filepath, 'r') do |file|
          contents = file.readlines.join("")
        end
      rescue => e
        Escort::Logger.error.warn("Error reading file #{filepath}")
      end
      contents
    end
  end
end
