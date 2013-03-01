module Ppjson
  class StreamJsonWriter
    attr_reader :stream

    def initialize(stream = $stdout)
      @stream = stream
    end

    def write(json, options = {:pretty => true})
      hash = from_json(json)
      stream.puts MultiJson.dump(hash, options)
    end

    private

    def from_json(json)
      MultiJson.load(json)
    rescue MultiJson::LoadError => e
      Escort::Logger.error.error "Invalid JSON string (don't forget to quote your strings e.g. '{\"abc\":\"def\"}'):"
      Escort::Logger.error.error e.message
      Escort::Logger.error.warn "#{json}"
      exit(1)
    end
  end
end
