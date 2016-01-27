module TodoBuster
  class Todo
    attr_accessor :line_number, :file_name, :commit_time, :committer

    def initialize(line_number:, file_name:)
      @line_number = line_number
      @file_name = file_name
    end
  end
end
