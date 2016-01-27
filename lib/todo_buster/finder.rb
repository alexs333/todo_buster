require 'active_support/all'
require 'terminal-table'
require 'todo_buster/version'
require 'todo_buster/configuration'
require 'todo_buster/todo'

module TodoBuster
  class Finder
    def search
      all_todos = find_all_todos
      expired_todos = git_blame all_todos
      print_violations expired_todos
      expired_todos
    end

    private

    def find_all_todos
      all_todos = []
      Dir.glob("#{Dir.pwd}/**/*.rb").each do |file|
        open(file).each_line.with_index(1).inject([]) do |_, i|
          all_todos << TodoBuster::Todo.new(line_number: i[1], file_name: file) if (i[0][/TODO/])
        end
      end
      all_todos
    end

    def parse_blame_output(raw_blame_output)
      blame_output = {}
      raw_blame_output.split("\n").each do |output_line|
        blame_output[output_line.split(' ')[0]] = output_line.split(' ')[1]
      end
      blame_output
    end

    def print_violations(expired_todos)
      headings = %w(line file committer)

      todo_violations_table = Terminal::Table.new headings: headings do |t|
        expired_todos.each do |todo|
          todo_columns = []
          todo_columns << todo.line_number
          todo_columns << todo.file_name
          todo_columns << todo.committer
          t << todo_columns
        end
      end
      puts todo_violations_table.to_s
    end

    def git_blame(all_todos)
      expired_todos = []
      all_todos.each do |todo|
        blame_output = parse_blame_output `git blame -p -L #{todo.line_number},#{todo.line_number} #{todo.file_name}`
        todo.commit_time = Time.at blame_output['committer-time'].to_i
        todo.committer = blame_output['committer']
        expired_todos << todo if todo.commit_time < (Time.now - TodoBuster.configuration.valid_period)
      end
      expired_todos
    end
  end
end
