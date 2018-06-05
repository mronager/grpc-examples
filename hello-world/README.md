# Hello World
This is the basic first getting-started example.

## Running
To run the service, run
```
$ bundle exec ruby ruby/helloworld.rb
```

It is now possible to query against this service by
```
$ grpcc -i -a localhost:3000 -p protos/helloworld.proto

  ...

  client - the client connection to HelloWorld
    greet (SayHello, callback) returns Hello

  ...

HelloWorld@localhost:3000> let ee = client.greet({ name: "Magnus R" }, pr);
HelloWorld@localhost:3000>
{
  "message": "Hello Magnus R"
}
```

## Testing
```
$ bundle exec ruby ruby/helloworld_test.rb
```
