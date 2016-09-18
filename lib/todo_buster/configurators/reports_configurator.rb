require_relative '../../../lib/todo_buster/configuration'

module TodoBuster
  module Configurators
    class ReportsConfigurator
      def apply_config(reporters)
        reporters.split(',').map(&:strip).each do |reporter|
          unless %w(CONSOLE HTML).include? reporter.upcase
            puts 'Invalid report, valid options are: CONSOLE or/and HTML'
            yield if block_given?
            exit
          end
        end
        TodoBuster.configuration.reporters = reporters
      end
    end
  end
end
