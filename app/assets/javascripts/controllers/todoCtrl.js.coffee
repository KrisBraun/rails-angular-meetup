todomvc.controller "TodoCtrl", ($scope, $location, Todo, filterFilter) ->
  Todo.query().then (todos) ->
    console.log todos
    $scope.todos = todos
  $scope.newTodo = ""
  $scope.editedTodo = null
  $scope.$watch "todos", ((newValue, oldValue) ->
    if $scope.todos
      $scope.remainingCount = filterFilter($scope.todos,
        completed: false
      ).length
      $scope.completedCount = $scope.todos.length - $scope.remainingCount
      $scope.allChecked = not $scope.remainingCount
  ), true
  $location.path "/" if $location.path() is ""
  $scope.location = $location
  $scope.$watch "location.path()", (path) ->
    $scope.statusFilter = (if (path is "/active") then completed: false else (if (path is "/completed") then completed: true else null))

  $scope.addTodo = ->
    newTodo = $scope.newTodo.trim()
    return unless newTodo.length
    new Todo(title: newTodo).create().then (todo) ->
      $scope.todos.push todo
    $scope.newTodo = ""

  $scope.editTodo = (todo) ->
    $scope.editedTodo = todo
    $scope.originalTodo = angular.extend({}, todo)

  $scope.doneEditing = (todo) ->
    $scope.editedTodo = null
    todo.title = todo.title.trim()
    if todo.title
      todo.save().then (updatedTodo) ->
        angular.extend todo, updatedTodo
    else
      $scope.removeTodo

  $scope.revertEditing = (todo) ->
    $scope.todos[$scope.todos.indexOf(todo)] = $scope.originalTodo
    $scope.doneEditing $scope.originalTodo

  $scope.removeTodo = (todo) ->
    todo.remove().then ->
      $scope.todos.splice $scope.todos.indexOf(todo), 1

  $scope.clearCompletedTodos = ->
    $scope.todos = $scope.todos.filter((val) ->
      not val.completed
    )

  $scope.markAll = (completed) ->
    $scope.todos.forEach (todo) ->
      todo.completed = completed
