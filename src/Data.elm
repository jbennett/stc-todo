module Data exposing (Model, Msg(..), Status(..), Todo, Todos, defaultTodos, initTodo, toggleTodo)

import Array exposing (Array)



-- System


type alias Model =
    { entryText : String
    , todos : Todos
    }


type Msg
    = TodoClicked Int Bool
    | EntryUpdated String
    | EntrySubmitted
    | NoOp



-- Todos


type alias Todo =
    { label : String
    , status : Status
    , favoriteNumber : Int
    }


initTodo : String -> Todo
initTodo label =
    Todo label Incomplete 3


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
    , "See the Northern Lights"
    , "Write a book"
    , "Go skydiving"
    , "Catch them all"
    , "Do a STC Talk"
    ]
        |> List.map initTodo
        |> Array.fromList


type alias Todos =
    Array Todo


type Status
    = Complete
    | Incomplete
