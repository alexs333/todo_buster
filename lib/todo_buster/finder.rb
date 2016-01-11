require 'todo_buster/version'
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
        puts todos.length
        puts `git blame -L #{todo.line_number},#{todo.line_number} #{todo.file_name}`.class
      end
    end

    def parse_blame_output(blame_output)
      puts "blame output: #{blame_output}"
      blame_output_list = blame_output.split
      date_string = blame_output_list[ (blame_output_list.length-4)..(blame_output_list.length-1) ].join ' '
      puts date_string
      Time.new date_string
    end
  end
end
