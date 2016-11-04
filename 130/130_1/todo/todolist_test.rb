require 'simplecov'
SimpleCov.start

require 'pry'
require 'minitest/autorun'
require "minitest/reporters"

Minitest::Reporters.use!

require_relative 'todo_list'

class TodoListTest < MiniTest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  # Your tests go here. Remember they must start with "test_"
  def todo_done
    @todo3.done!
    assert_equal(false, @todo1.done)
    assert_equal(true, @todo3.done)
  end
  
  def todo_to_s
    assert_equal("[] Buy milk", @todo1.to_s)
    @todo2.done!
    assert_equal("[X] Clean room", @todo2.to_s)
  end
  
  def test_todolist_to_a
    assert_equal(@todos, @list.to_a)
  end
  
  def test_initialize_todolist_with_title
    title = "Pet Care"
    new_list = TodoList.new(title)
    assert_equal(title, new_list.title)
  end
  
  def test_todolist_change_title
    @list.title = "Fish Care"
    assert_equal("Fish Care", @list.title)
  end

  def test_todolist_size
    assert_equal(3, @list.size)
  end

  def test_todolist_first
    assert_equal(@todo1, @list.first)
  end

  def test_todolist_last
    assert_equal(@todo3, @list.last)
  end

  def test_todolist_shift
    assert_equal(@todo1, @list.shift)
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_todolist_pop
    todo4 = Todo.new("Wash car")
    @list.add(todo4) 
    assert_equal(todo4, @list.pop)
    assert_equal([@todo1, @todo2, @todo3], @list.to_a)
  end

  def test_todolist_item_at
    assert_raises(IndexError) {@list.item_at(5)}
    assert_equal(@todo3, @list.item_at(2))
  end

  def test_todolist_mark_done_at
    assert_raises(IndexError) {@list.mark_done_at(5)}
    @list.mark_done_at(1)
    assert(@todo2.done?)
    assert_equal(false, @todo1.done?)
  end

  def test_todolist_mark_undone_at
    assert_raises(IndexError) {@list.mark_undone_at(5)}
    @todo2.done!
    @todo3.done!
    @list.mark_undone_at(1)
    assert_equal(false, @todo2.done?)
    assert_equal(true, @todo3.done?)
  end

  def test_todolist_remove_at
    assert_raises(IndexError) {@list.remove_at(5)}
    @list.remove_at(0)
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_todolist_done?
    @todo1.done!
    assert_equal(false, @list.done?)
    @todo2.done!
    @todo3.done!
    assert_equal(true, @list.done?)
  end

  def test_todolist_done!
    @list.done!
    assert_equal(true, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(true, @todo3.done?)  
  end

  def test_todolist_raise_add_shovel_non_todo
    assert_raises(TypeError) { @list << "string" }
  end

  def test_todolist_add_shovel
    @list << @todo1
    assert_equal([@todo1, @todo2, @todo3, @todo1], @list.to_a)
  end
  
  def test_todolist_raise_add_non_todo
    assert_raises(TypeError) { @list.add("string") }
  end
  
  def test_todolist_add
    @list.add(@todo1)
    assert_equal([@todo1, @todo2, @todo3, @todo1], @list.to_a)
  end

  def test_todolist_mark_all_done
    @list.mark_all_done
    assert_equal(true, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(true, @todo3.done?)  
  end

  def test_todolist_mark_all_undone
    @list.first.done!
    @list.last.done!
    @list.mark_all_undone
    assert_equal(false, @todo1.done?)
    assert_equal(false, @todo2.done?)
    assert_equal(false, @todo3.done?)
  end

  def test_todolist_each
    change_arr = []
    @list.each do |todo|
      change_arr << todo.title = "Blank"
    end
    assert_equal(["Blank", "Blank", "Blank"], change_arr)
  end

  def test_todolist_each_return_val
    assert_equal(@list, @list.each { |todo| todo.done! })
  end

  def test_todolist_select
    list = TodoList.new(@list.title)
    @todo1.done!
    list << @todo1
    results = list.select { |todo| todo.done? }
    assert_equal(list.to_s, results.to_s)
  end

  def test_todolist_to_s
    output = <<-OUTPUT.gsub(/^\s+/, "")
    ----Today's Todos----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_todolist_to_s_one_todo_done
    @list.mark_done_at(1)

    output = <<-OUTPUT.gsub(/^\s+/, "")
    ----Today's Todos----
    [ ] Buy milk
    [X] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end
  
  def test_todolist_find_by_title
    assert(@todo1, @list.find_by_title("Buy"))
  end

  def test_todolist_mark_done_text
    @list.mark_done("Buy")
    assert(@todo1)
  end

  def test_todolist_all_done
<<<<<<< HEAD
    @list.mark_done_at(1)
    assert_equal(@todo2.title, @list.all_done.first.title)
    assert(@list.all_done.first.done?)
  end

  def test_todolist_all_not_done
    @list.mark_done_at(1)
    not_complete = @list.all_not_done
    assert_equal(@todo1.title, not_complete.first.title)
    assert_equal(@todo3.title, not_complete.last.title)
    refute(not_complete.first.done?)
=======
    @list.mark_done_at(2)
    @list.mark_done_at(0)
    results = @list.all_done
    assert_includes(results.to_a, @todo1)
    assert_includes(results.to_a, @todo3)
  end

  def test_todolist_all_not_done
    @list.mark_done_at(2)
    @list.mark_done_at(0)
    results = @list.all_not_done
    assert_includes(results.to_a, @todo2)
    refute_includes(results.to_a, @todo3)
    refute_includes(results.to_a, @todo1)
>>>>>>> e5782d0639881fbbf138b7754d2af0bc56afdd41
  end 
end