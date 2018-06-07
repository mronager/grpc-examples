# Todo list
This is a slightly more sofisticated example that shows very basic CRUD operations for a simple TODO list.

## Running
To run the service, run
```
$ bundle exec ruby ruby/todo.rb
```

It is now possible to query against this service by
```
$  grpcc -i -a localhost:3000 -p protos/todo.proto

  ...

  client - the client connection to Todo
    addItem (AddItemRequest, callback) returns ItemAdded
    removeItem (RemoveItemRequest, callback) returns ItemRemoved
    toggleItem (ToggleItemRequest, callback) returns ItemToggled
    listItems (ListItemsRequest, callback) returns Item

  ...
  Todo@localhost:3000> client.addItem({ name: "Buy Milk" }, pr);
  {
    "id": "1c5fbe26e5a26883583bdca3c3572dda"
  }
  Todo@localhost:3000> client.addItem({ name: "Buy Eggs" }, pr);
  {
    "id": "fb1ba2e44329ec2212bc71d4ae9ca58c"
  }
  Todo@localhost:3000> client.addItem({ name: "Clean House" }, pr);
  {
    "id": "231707ff583b2ce9ad75a59b86471c18"
  }
  Todo@localhost:3000> client.toggleItem({ id: "231707ff583b2ce9ad75a59b86471c18" }, pr);
  {}
  Todo@localhost:3000> client.listItems({}).on('data', sr);
  {
    "id": "1c5fbe26e5a26883583bdca3c3572dda",
    "name": "Buy Milk",
    "completed": false
  }
  {
    "id": "fb1ba2e44329ec2212bc71d4ae9ca58c",
    "name": "Buy Eggs",
    "completed": false
  }
  {
    "id": "231707ff583b2ce9ad75a59b86471c18",
    "name": "Clean House",
    "completed": true
  }
```

## Testing
```
$ bundle exec ruby ruby/todo_test.rb
```
