# gRPC-examples
This repository contains code examples of gRPC implementations.

## Getting started

### Ruby
Start by installing the dependencies for the examples by running
```
$ bundle install
```

### Protobuf
gRPC uses Protobuf, so in order to compile the protobuf schemas into the relevant stubs, navigate into one of the ruby directories and run.
```
$ grpc_tools_ruby_protoc -I ../protos --ruby_out=lib/ --grpc_out=lib/ ../protos/helloworld.proto
```

### grpcc
For testing the server implementation, any tool may work. I personally found `grpcc` to be easily installed and work tremendously well.
```
$ npm install -g grpcc
```

## License
MIT
