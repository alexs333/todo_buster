module TodoBuster
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield configuration if block_given?
  end

  class Configuration
    attr_accessor :valid_period

    def initialize
      @valid_period = 1.month
    end
  end
end
