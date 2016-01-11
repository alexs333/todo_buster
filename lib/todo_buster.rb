require 'todo_buster/version'

class TodoBuster::Finder
  def find_todos
    puts "currently in directory: #{Dir.pwd}"

    todos = []

    Dir.glob("#{Dir.pwd}/**/*.rb").each do |test|
      todos << open(test).each_line.with_index(1).inject([]) do |m, i|
        m << i if (i[0][/TODO/])
        m
      end
    end

    # puts todos[0]
    # puts todos[1]

    #  git blame -L 1,1 Vagrantfile
    puts todos[2]
  end
end
