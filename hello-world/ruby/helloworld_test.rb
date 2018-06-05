require_relative "./helloworld"
require "test/unit"

class HelloWorldTest < Test::Unit::TestCase

  def setup
    @server = HelloWorldServer.new
  end

  def test_greet_should_say_hello_when_given_name
    ret = @server.greet(SayHello.new(name: "Magnus"), nil)
    assert_equal(Hello.new(message: "Hello Magnus"), ret)
  end
end
