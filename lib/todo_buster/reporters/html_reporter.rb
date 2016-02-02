require 'html/table'

module TodoBuster
  module Reporters
    class HtmlReporter
      def initialize(todos)
        @todos = todos
      end

      def generate
        Dir.mkdir(TodoBuster.configuration.output_dir) unless File.exists?(TodoBuster.configuration.output_dir)

        table = HTML::Table.new { style 'border: 1px solid black; background-color: lightgreen' }
        headers = HTML::Table::Row.new { |row| row.bgcolor = 'green' }
        %w(line file committer).each do |header_content|
          headers.push( HTML::Table::Row::Header.new do |header|
            header.content = header_content.capitalize
            header.style = 'color: white; text-align: left; padding: 10px;'
          end)
        end
        table.push headers
        if @todos.any?
          @todos.each do |todo|
            table.push HTML::Table::Row.new{ |row| row.content = [todo.line_number, todo.file_name, todo.committer] }
          end
        else
          table.push HTML::Table::Row.new{ |row| row.content = 'No TODO violations had been found' }
        end

        File.open("#{TodoBuster.configuration.output_dir}/todo_report.html", 'w') { |file| file.write(table.html) }
      end
    end
  end
end
