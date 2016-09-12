class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER }] #{title}"
  end
end


class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def <<(todo)
    raise TypeError, 'Can only add Todo objects' unless todo.instance_of? Todo
    
    @todos << todo
    @todos
  end
  alias_method :add, :<<

  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def item_at(index)
    @todos.fetch(index)
  end

  def mark_done_at(index)
    @todos.fetch(index).done!
  end

  def mark_undone_at(index)
    @todos.fetch(index).undone!
  end

  def done?
    arr = @todos.select { |todo| todo.done? }
    arr.count == @todos.count
  end

  def done!
    @todos.each { |todo| todo.done! }
  end
  alias_method :mark_all_done, :done!

  def mark_all_undone
    @todos.each { |todo| todo.undone! }
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(index)
    @todos.delete(item_at(index))
  end

  def to_s
    str = "----"
    str += self.title
    str += "----\n"
    @todos.each do |todo|
      str += todo.to_s + "\n"
    end
    str
  end

  def to_a
    @todos
  end

  def each
    counter = 0
    while counter < @todos.count
      yield(@todos[counter])
      counter += 1
    end
    self
  end

  def select
    counter = 0
    new_list = TodoList.new(@title)
    loop do 
      break if counter == @todos.count
      new_list << @todos[counter] if yield(@todos[counter])
      counter += 1
    end
    new_list
  end
  
  def all_done
    done_todos = TodoList.new(self.title)
    todo_arr = self.select { |todo| todo.done? }
    todo_arr.each do |todo|
      done_todos.add(todo)
    end
    done_todos
  end
  
  def all_not_done
    done_todos = TodoList.new(self.title)
    todo_arr = self.select { |todo| !todo.done? }
    todo_arr.each do |todo|
      done_todos.add(todo)
    end
    done_todos
  end
  
  def find_by_title(string)
    results = @todos.select do |todo|
                todo.title.downcase.match(string.downcase)
              end
    return results.first unless results.nil?
    nil
  end
  
  def mark_done(string)
    result = find_by_title(string)
    result.done! unless result.nil?
  end
end