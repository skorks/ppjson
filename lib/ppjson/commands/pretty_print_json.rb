module Ppson
  module Commands
    class PrettyPrintJson < ::Escort::ActionCommand::Base
      def execute
        if command_options[:file] && command_options[:inline] && command_options[:undo]
        elsif command_options[:file] && command_options[:inline]
          pretty_print_json_string_back_to_file
        elsif command_options[:file] && command_options[:undo]
        elsif command_options[:file]
          pretty_print_json_strings_to_stream(json_strings_from_file_arguments)
        else
          pretty_print_arguments_to_stdout
        end
      end

      private

      def json_strings_from_file_arguments
        json_strings = []
        arguments.each do |filepath|
          begin
            File.open(filepath, 'r') do |file|
              json_strings << file.readlines.join("")
            end
          rescue => e
            Escort::Logger.error.warn("Error reading file #{filepath}")
          end
        end
        json_strings
      end

      def pretty_print_arguments_to_stdout
        pretty_print_json_strings_to_stream(arguments.map(&:to_s), $stdout)
      end

      def pretty_print_json_strings_to_stream(json_strings, stream = $stdout)
        json_strings.each do |json_string|
          pretty_print_to_stream(json_string, stream)
        end
      end

      def pretty_print_to_stream(json_string, stream)
        hash = from_json(json_string)
        stream.puts MultiJson.dump(hash, :pretty => true)
      end

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
