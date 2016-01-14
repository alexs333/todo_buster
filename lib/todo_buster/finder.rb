require 'active_support/all'
require 'todo_buster/version'
require 'todo_buster/configuration'
require 'todo_buster/todo'

module TodoBuster
  class Finder
    def find_todos
      todos = []

      Dir.glob("#{Dir.pwd}/**/*.rb").each do |file|
        open(file).each_line.with_index(1).inject([]) do |m, i|
          todos << TodoBuster::Todo.new(line_number: i[1], file_name: file) if (i[0][/TODO/])
        end
      end

      todos.each do |todo|
        blame_output = parse_blame_output `git blame -p -L #{todo.line_number},#{todo.line_number} #{todo.file_name}`
        todo.commit_time = Time.at blame_output['committer-time'].to_i
      end
    end

    private

    def parse_blame_output(raw_blame_output)
      blame_output = {}
      raw_blame_output.split("\n").each do |output_line|
        blame_output[output_line.split(' ')[0]] = output_line.split(' ')[1]
      end
      blame_output
    end
  end
end
