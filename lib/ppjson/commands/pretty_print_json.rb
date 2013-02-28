module Ppson
  module Commands
    class PrettyPrintJson < ::Escort::ActionCommand::Base
      class ArgumentsFactory
        class << self
          def create(options, arguments)
            if options[:file]
              FileArguments.new(options, arguments)
            else
              JsonStringArguments.new(options, arguments)
            end
          end
        end
      end

      class JsonStringArguments
        attr_reader :options, :arguments

        def initialize(options, arguments)
          @options = options
          @arguments = arguments
        end

        def each(&block)
          arguments.each do |argument|
            block.call(argument)
          end
        end
      end

      class FileArguments
        attr_reader :options, :arguments

        def initialize(options, arguments)
          @options = options
          @arguments = arguments
        end
      end

      class FileArgument
        attr_reader :filepath, :options

        def initialize(filepath, options = {})
          @filepath = filepath
          @options = options
        end

        def process
          #read file contents
          #use inline option to decide if stream is stdout or file
          #produce a jsonstring argument with
          #inline and undo need to be considered
        end

        private

        def output_stream
          if options[:inline]
            File.open(filepath, "w")
          else
            $stdout
          end
        end
      end

      #class JsonString
        #attr_reader :value, :pretty

        #def initialize(value, pretty = true)
          #@value = value
          #@pretty = pretty
        #end

        #def process
          #Ppjson::StreamJsonWriter.write(value, :pretty => pretty)
        #end
      #end

      def execute
        ArgumentsFactory.create(command_options).each do |argument|
          argument.process
          #Ppjson::StreamJsonWriter.write(argument, :pretty => true)
        end
        #ArgumentsFactory.create(command_options).each do |argument|
          #Ppjson::StreamJsonWriter.write(argument, :pretty => true)
        #end

        if command_options[:file] && command_options[:inline] && command_options[:undo]
          unpretty_print_json_strings_back_to_file
        elsif command_options[:file] && command_options[:inline]
          pretty_print_json_strings_back_to_file
        elsif command_options[:file] && command_options[:undo]
          unpretty_print_json_strings_to_stream
        elsif command_options[:file]
          pretty_print_json_strings_to_stream(json_strings_from_file_arguments)
        else
          pretty_print_arguments_to_stdout
        end
      end

      private

      def unpretty_print_json_strings_back_to_file
        arguments.each do |filepath|
          json_string = nil
          begin
            File.open(filepath, 'r') do |file|
              json_string = file.readlines.join("")
            end
          rescue => e
            Escort::Logger.error.warn("Error reading file #{filepath}")
          end

          begin
            File.open(filepath, 'w') do |file|
              unpretty_print_to_stream(json_string, file)
            end
          rescue => e
            Escort::Logger.error.warn("Error writing file #{filepath}")
          end
        end
      end

      def unpretty_print_json_strings_to_stream
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
        json_strings.each do |json_string|
          unpretty_print_to_stream(json_string, $stdout)
        end
      end

      def pretty_print_json_strings_back_to_file
        arguments.each do |filepath|
          json_string = nil
          begin
            File.open(filepath, 'r') do |file|
              json_string = file.readlines.join("")
            end
          rescue => e
            Escort::Logger.error.warn("Error reading file #{filepath}")
          end

          begin
            File.open(filepath, 'w') do |file|
              pretty_print_to_stream(json_string, file)
            end
          rescue => e
            Escort::Logger.error.warn("Error writing file #{filepath}")
          end
        end
      end

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

      def unpretty_print_to_stream(json_string, stream)
        hash = from_json(json_string)
        stream.puts MultiJson.dump(hash, :pretty => false)
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
