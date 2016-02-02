require 'terminal-table'

module TodoBuster
  module Reporters
    class ConsoleReporter
      def initialize(todos)
        @todos = todos
      end

      def generate
        if @todos.any?
          headings = %w(line file committer)
          todo_violations_table = Terminal::Table.new headings: headings do |t|
            @todos.each do |todo|
              todo_columns = []
              todo_columns << todo.line_number
              todo_columns << todo.file_name
              todo_columns << todo.committer
              t << todo_columns
            end
          end
          puts todo_violations_table.to_s
        else
          puts 'No TODO violations had been found'
        end
      end
    end
  end
end
