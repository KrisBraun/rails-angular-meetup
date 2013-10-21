todomvc.factory 'Todo', ['RailsResource', (RailsResource) ->
  class Todo extends RailsResource
    @configure
      url: "/api/todos"
      name: "todo"
      pluralName: "todos"
]
