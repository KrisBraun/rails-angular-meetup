# Directive that executes an expression when the element it is applied to gets
# an `escape` keydown event.
todomvc.directive "todoEscape", ->
  ESCAPE_KEY = 27
  (scope, elem, attrs) ->
    elem.bind "keydown", (event) ->
      scope.$apply attrs.todoEscape  if event.keyCode is ESCAPE_KEY
