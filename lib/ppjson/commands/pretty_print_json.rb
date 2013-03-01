module Ppson
  module Commands
    class PrettyPrintJson < ::Escort::ActionCommand::Base
      def execute
        ArgumentsDecorator.new(arguments, command_options).decorate.each do |argument|
          argument.process
        end
      end
    end
  end
end
