todomvc.controller "TodoCtrl", ($scope, $location, todoStorage, filterFilter) ->
  todos = $scope.todos = todoStorage.get()
  $scope.newTodo = ""
  $scope.editedTodo = null
  $scope.$watch "todos", ((newValue, oldValue) ->
    $scope.remainingCount = filterFilter(todos,
      completed: false
    ).length
    $scope.completedCount = todos.length - $scope.remainingCount
    $scope.allChecked = not $scope.remainingCount
    todoStorage.put todos  if newValue isnt oldValue
  ), true
  $location.path "/"  if $location.path() is ""
  $scope.location = $location
  $scope.$watch "location.path()", (path) ->
    $scope.statusFilter = (if (path is "/active") then completed: false else (if (path is "/completed") then completed: true else null))

  $scope.addTodo = ->
    newTodo = $scope.newTodo.trim()
    return  unless newTodo.length
    todos.push
      title: newTodo
      completed: false

    $scope.newTodo = ""

  $scope.editTodo = (todo) ->
    $scope.editedTodo = todo
    $scope.originalTodo = angular.extend({}, todo)

  $scope.doneEditing = (todo) ->
    $scope.editedTodo = null
    todo.title = todo.title.trim()
    $scope.removeTodo todo  unless todo.title

  $scope.revertEditing = (todo) ->
    todos[todos.indexOf(todo)] = $scope.originalTodo
    $scope.doneEditing $scope.originalTodo

  $scope.removeTodo = (todo) ->
    todos.splice todos.indexOf(todo), 1

  $scope.clearCompletedTodos = ->
    $scope.todos = todos = todos.filter((val) ->
      not val.completed
    )

  $scope.markAll = (completed) ->
    todos.forEach (todo) ->
      todo.completed = completed
