todomvc.factory "todoStorage", ->
  STORAGE_ID = "todos-angularjs"
  get: ->
    JSON.parse localStorage.getItem(STORAGE_ID) or "[]"

  put: (todos) ->
    localStorage.setItem STORAGE_ID, JSON.stringify(todos)
