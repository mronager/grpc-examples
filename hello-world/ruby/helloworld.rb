#!/usr/bin/env ruby
dir = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(dir, 'lib'))

require 'grpc'
require 'helloworld_services_pb'

require 'logger'

class HelloWorldServer < HelloWorld::Service
  def greet(hello_req, _unused_call)
    Hello.new(message: "Hello #{hello_req.name}")
  end
end

def main
  logger = Logger.new(STDOUT)
  addr = "0.0.0.0:3000"
  s = GRPC::RpcServer.new
  s.add_http2_port(addr, :this_port_is_insecure)
  logger.info("HelloWorldServer running insecurely on #{addr}")
  s.handle(HelloWorldServer)
  s.run_till_terminated
end

main if __FILE__ == $PROGRAM_NAME
