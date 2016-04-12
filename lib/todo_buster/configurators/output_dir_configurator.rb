require_relative '../../../lib/todo_buster/configuration'

module TodoBuster
  module Configurators
    class OutputDirConfigurator
      def apply_config(output_dir)
        begin
          TodoBuster.configuration.output_dir = output_dir.strip
        rescue
          puts 'Invalid output directory'
          yield if block_given?
          exit
        end
      end
    end
  end
end
