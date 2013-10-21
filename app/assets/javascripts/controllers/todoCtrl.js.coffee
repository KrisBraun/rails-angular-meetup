todomvc.controller "TodoCtrl", ($scope, $location, Todo, filterFilter) ->
  Todo.query().then (todos) -> $scope.todos = todos
  $scope.newTodo = ""
  $scope.editedTodo = null
  $scope.$watch "todos", (->
    if $scope.todos
      $scope.remainingCount = filterFilter($scope.todos, (a) -> not a.completed).length
      $scope.completedCount = $scope.todos.length - $scope.remainingCount
      $scope.allChecked = not $scope.remainingCount
  ), true
  $location.path "/" if $location.path() is ""
  $scope.location = $location
  $scope.$watch "location.path()", (path) ->
    $scope.statusFilter =
      if path is "/active"
        (t) -> not t.completed
      else if path is "/completed"
        (t) -> t.completed
      else null

  $scope.addTodo = ->
    newTodo = $scope.newTodo.trim()
    return unless newTodo.length
    new Todo(title: newTodo).create().then (todo) ->
      $scope.todos.push todo
    $scope.newTodo = ""

  $scope.editTodo = (todo) ->
    $scope.editedTodo = todo
    $scope.originalTodo = angular.extend({}, todo)

  $scope.doneEditing = ->
    return unless $scope.editedTodo
    $scope.editedTodo.title = $scope.editedTodo.title.trim()
    if $scope.editedTodo.title
      $scope.editedTodo.save().then (updatedTodo) ->
        angular.extend $scope.editedTodo, updatedTodo
    else
      $scope.removeTodo $scope.editedTodo
    $scope.editedTodo = null

  $scope.revertEditing = (todo) ->
    $scope.todos[$scope.todos.indexOf(todo)] = $scope.originalTodo
    $scope.doneEditing $scope.originalTodo

  $scope.removeTodo = (todo) ->
    todo.remove().then ->
      $scope.todos.splice $scope.todos.indexOf(todo), 1

  $scope.clearCompletedTodos = ->
    $scope.removeTodo todo for todo in $scope.todos.filter((val) -> val.completed)

  $scope.markAll = (completed) ->
    $scope.todos.forEach (todo) ->
      todo.completed = completed

  $scope.completeChanged = (todo) ->
    todo.save()
