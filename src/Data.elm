module Data exposing (Status(..), Todo, Todos, initTodo, toggleTodo)

import Array exposing (Array)


type alias Todo =
    { label : String
    , status : Status
    }


initTodo : String -> Todo
initTodo label =
    Todo label Incomplete


toggleTodo : Todo -> Todo
toggleTodo todo =
    case todo.status of
        Complete ->
            { todo | status = Incomplete }

        Incomplete ->
            { todo | status = Complete }


type alias Todos =
    Array Todo


type Status
    = Complete
    | Incomplete
