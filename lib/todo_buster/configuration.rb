module TodoBuster
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new

    if File.file? '.todo_buster'
      File.open('.todo_buster').each_line do |line|
        option = line.split '='
        "TodoBuster::Configurators::#{option[0].split('-').map(&:humanize).join}Configurator".constantize.new.apply_config option[1]
      end
    end
  end

  class Configuration
    attr_accessor :valid_period, :reporters, :output_dir, :file_masks

    def initialize
      @valid_period = 1.month
      @reporters = %w(CONSOLE HTML)
      @output_dir = 'todo_reports'
      @file_masks = %w(*.js *.rb *.coffee)
    end
  end
end
