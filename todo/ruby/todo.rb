#!/usr/bin/env ruby
dir = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(dir, 'lib'))

require 'grpc'
require 'securerandom'
require 'todo_services_pb'

require 'logger'

class TodoServer < Todo::Service

  def initialize
    @todos = Hash.new
  end

  def add_item(add_item_req, _unused_call)
    item = Item.new(
      id: SecureRandom.hex,
      name: add_item_req.name,
      completed: false,
    )
    @todos[item.id] = item
    puts @todos
    ItemAdded.new(id: item.id)
  end

  def remove_item(remove_item_req, _unused_call)
    @todos.delete(remove_item_req.id)
    ItemRemoved.new
  end

  def toggle_item(toggle_item_req, _unused_call)
    item = @todos[toggle_item_req.id]
    item.completed = !item.completed
    @todos[item.id] = item
    ItemToggled.new
  end

  def list_items(list_items_req, _unused_call)
    each_item
  end

  def each_item
    return enum_for(:each_item) unless block_given?
    @todos.each do |_,v|
      yield v
    end
  end
end

def main
  logger = Logger.new(STDOUT)
  addr = "0.0.0.0:3000"
  s = GRPC::RpcServer.new
  s.add_http2_port(addr, :this_port_is_insecure)
  logger.info("TodoServer running insecurely on #{addr}")
  s.handle(TodoServer.new)
  s.run_till_terminated
end

main if __FILE__ == $PROGRAM_NAME

