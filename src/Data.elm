module Data exposing (Status(..), Todo, Todos, defaultTodos, initTodo, toggleTodo)

import Array exposing (Array)


type alias Todo =
    { label : String
    , status : Status
    , favoriteNumber : Int
    }


initTodo : String -> Todo
initTodo label =
    Todo label Incomplete 7


toggleTodo : Todo -> Todo
toggleTodo todo =
    case todo.status of
        Complete ->
            { todo | status = Incomplete }

        Incomplete ->
            { todo | status = Complete }


defaultTodos : Todos
defaultTodos =
    [ "Get 250ml tomato sauce"
    , "Try to take over the world"
    ]
        |> List.map initTodo
        |> Array.fromList


type alias Todos =
    Array Todo


type Status
    = Complete
    | Incomplete
