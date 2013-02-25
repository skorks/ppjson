module Ppson
  module Commands
    class PrettyPrintJson < ::Escort::ActionCommand::Base
      def execute
        arguments.each do |argument|
          hash = from_json(argument.to_s)
          $stdout.puts MultiJson.dump(hash, :pretty => true)
        end
      end

      private

      def from_json(json)
        MultiJson.load(json)
      rescue MultiJson::LoadError => e
        $stderr.puts "Invalid JSON string (don't forget to quote your strings e.g. '{\"abc\":\"def\"}'):"
        $stderr.puts e.message
        $stderr.puts "#{json}"
        exit(1)
      end
    end
  end
end
