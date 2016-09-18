require_relative '../../../lib/todo_buster/configuration'

module TodoBuster
  module Configurators
    class FileMasksConfigurator
      def apply_config(file_masks)
        file_masks.split(',', -1).each do |file_mask|
          if file_mask.strip.length < 1
            puts 'Invalid file mask'
            yield if block_given?
            exit
          end
          TodoBuster.configuration.file_masks = file_masks.split(',').map(&:strip)
        end
      end
    end
  end
end
