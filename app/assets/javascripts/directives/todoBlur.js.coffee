# Directive that executes an expression when the element it is applied to loses focus
todomvc.directive "todoBlur", ->
  (scope, elem, attrs) ->
    elem.bind "blur", ->
      scope.$apply attrs.todoBlur
