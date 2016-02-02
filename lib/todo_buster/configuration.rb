module TodoBuster
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
  end

  class Configuration
    attr_accessor :valid_period, :reporters, :output_dir

    def initialize
      @valid_period = 1.month
      @reporters = %w(CONSOLE HTML)
      @output_dir = 'todo_reports'
    end
  end
end
