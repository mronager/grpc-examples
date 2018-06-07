require_relative "./todo"
require "test/unit"

class TestTodo < Test::Unit::TestCase

  def setup
    @todo = TodoServer.new
  end

  def test_add_item_should_return_id
    item = add_item("test")
    assert_not_nil(item.id)
  end

  def test_add_item_should_add_item
    id = add_item("test").id
    assert_not_nil(get_item(id))
  end

  def test_add_item_should_add_item_with_uncompleted_state
    id = add_item("test").id
    assert_false(get_item(id).completed)
  end

  def test_add_item_should_allow_duplicates
    add_item("test duplicate")
    add_item("test duplicate")
    assert_equal(2, @todo.list_items(nil, nil).select { |item| item.name == "test duplicate" }.count)
  end

  def test_remove_item_should_remove_item
    id = add_item("test 1").id
    remove_item(id)
    assert_nil(get_item(id))
  end

  def test_remove_item_should_retain_other_items
    id1 = add_item("test 1").id
    id2 = add_item("test 2").id
    remove_item(id2)
    assert_not_nil(get_item(id1))
    assert_nil(get_item(id2))
  end

  def test_toggle_item_should_change_completed_state
    id = add_item("test toggle").id
    @todo.toggle_item(ToggleItemRequest.new(id: id), nil)
    assert_true(get_item(id).completed)
  end

  private

  def add_item(name)
    @todo.add_item(AddItemRequest.new(name: name), nil)
  end

  def remove_item(id)
    @todo.remove_item(RemoveItemRequest.new(id: id), nil)
  end

  def get_item(id)
    @todo.list_items(nil, nil).select { |item| item.id == id }.first
  end
end
