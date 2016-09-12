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
    begin
      unless todo.class == Todo
        raise TypeError, "Can only add Todo objects"
      end
      @todos << todo
      @todos

      rescue => e
        p e
        exit 1
    end
  end
  alias_method :add, :<<

  # def size
  #   @todos.size
  # end

  # def first
  #   @todos.first
  # end

  # def last
  #   @todos.last
  # end

  # def item_at(index)
  #   @todos.fetch(index)
  # end

  # def mark_done_at(index)
  #   @todos.fetch(index).done!
  # end

  # def mark_undone_at(index)
  #   @todos.fetch(index).undone!
  # end

  # def done?
  #   arr = @todos.select { |todo| todo.done? }
  #   arr.count == @todos.count
  # end

  # def done!
  #   @todos.each { |todo| todo.done! }
  # end
  # alias_method :mark_all_done, :done!

  # def mark_all_undone
  #   @todos.each { |todo| todo.undone! }
  # end

  # def shift
  #   @todos.shift
  # end

  # def pop
  #   @todos.pop
  # end

  # def remove_at(index)
  #   @todos.delete(item_at(index))
  # end

  # def to_s
  #   str = "----"
  #   str += self.title
  #   str += "----\n"
  #   @todos.each do |todo|
  #     str += todo.to_s + "\n"
  #   end
  #   str
  # end

  # def to_a
  #   @todos
  # end

  # def each
  #   counter = 0
  #   while counter < @todos.count
  #     yield(@todos[counter])
  #     counter += 1
  #   end
  #   self
  # end

  # def select
  #   counter = 0
  #   new_list = TodoList.new(@title)
  #   loop do 
  #     break if counter == @todos.count
  #     new_list << @todos[counter] if yield(@todos[counter])
  #     counter += 1
  #   end
  #   new_list
  # end
end

# todo1 = Todo.new("Buy milk")
# todo2 = Todo.new("Clean room")
# todo3 = Todo.new("Go to gym")
# list = TodoList.new("Today's Todos")

# # ---- Adding to the list -----

# # add
# list.add(todo1)                 # adds todo1 to end of list, returns list
# list.add(todo2)                 # adds todo2 to end of list, returns list

# # list.add(1)                     # raises TypeError with message "Can only add Todo objects"

# # <<
# # same behavior as add
# list << todo3                 # adds todo3 to end of list, returns list

# # ---- Interrogating the list -----

# # size
# list.size                       # returns 3

# # first
# list.first                      # returns todo1, which is the first item in the list

# # last
# list.last                       # returns todo3, which is the last item in the list

# # ---- Retrieving an item in the list ----

# # item_at
# # list.item_at                    # raises ArgumentError
# list.item_at(1)                 # returns 2nd item in list (zero based index)
# # list.item_at(100)               # raises IndexError

# # ---- Marking items in the list -----

# # mark_done_at
# # list.mark_done_at               # raises ArgumentError
# list.mark_done_at(1)            # marks the 2nd item as done
# # list.mark_done_at(100)          # raises IndexError

# # mark_undone_at
# # list.mark_undone_at             # raises ArgumentError
# # list.mark_undone_at(1)          # marks the 2nd item as not done,
# # list.mark_undone_at(100)        # raises IndexError

# # ---- Deleting from the the list -----

# # shift
# # list.shift                      # removes and returns the first item in list

# # pop
# # list.pop                        # removes and returns the last item in list

# # remove_at
# # list.remove_at                  # raises ArgumentError
# # list.remove_at(1)               # removes and returns the 2nd item
# # list.remove_at(100)             # raises IndexError

# # ---- Outputting the list -----

# # to_s
# puts list.to_s                      # returns string representation of the list

# # ---- Today's Todos ----
# # [ ] Buy milk
# # [ ] Clean room
# # [ ] Go to gym

# # or, if any todos are done

# # ---- Today's Todos ----
# # [ ] Buy milk
# # [X] Clean room
# # [ ] Go to gym


# todo1 = Todo.new("Buy milk")
# todo2 = Todo.new("Clean room")
# todo3 = Todo.new("Go to gym")

# list = TodoList.new("Today's Todos")
# list.add(todo1)
# list.add(todo2)
# list.add(todo3)

# puts list

# list.pop

# puts list

# list.mark_done_at(1)

# puts list

# results = list.select { |todo| todo.done? }    # you need to implement this method

# puts results.inspect