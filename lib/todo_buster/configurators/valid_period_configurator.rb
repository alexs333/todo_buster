require_relative '../../../lib/todo_buster/configuration'

module TodoBuster
  module Configurators
    class ValidPeriodConfigurator
      def apply_config(valid_period)
        begin
          number_of_units, unit_type = valid_period.split '.'
          TodoBuster.configuration.valid_period = number_of_units.strip.to_i.send unit_type.strip
        rescue
          puts 'Invalid validity period'
          yield if block_given?
          exit
        end
      end
    end
  end
end
