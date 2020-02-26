module Views exposing (contentContainer, footer, masthead, todoEntry, todosList, todosSummary)

import Array exposing (Array)
import Data exposing (Todo, Todos)
import Helpers exposing (onEnter)
import Html exposing (Html, div, h1, input, label, text)
import Html.Attributes exposing (class, placeholder, type_, value)
import Html.Events exposing (onCheck, onInput)


masthead : Html msg
masthead =
    h1 [ class "font-serif text-center text-blue-900 text-6xl" ] [ text "Todos" ]


footer : Html msg
footer =
    div []
        [ text "Copyright © 2020 Jonathan Bennett" ]


todosList : (Int -> Bool -> msg) -> Todos -> Html msg
todosList eventHandler todos =
    todos
        |> Array.indexedMap (\index todo -> todoRow index eventHandler todo)
        |> Array.toList
        |> div []


todosSummary : Todos -> Html msg
todosSummary todos =
    let
        count =
            todos
                |> Array.filter (\todo -> todo.status == Data.Incomplete)
                |> Array.length

        label =
            if count == 1 then
                "item"

            else
                "items"
    in
    div
        [ class "px-4 py-2"
        , class "border-t text-sm"
        ]
        [ [ String.fromInt count, label, "Remaining" ]
            |> String.join " "
            |> text
        ]


todoRow : Int -> (Int -> Bool -> msg) -> Todo -> Html msg
todoRow index eventHandler todo =
    div []
        [ label
            [ class "flex items-center px-4 py-2"
            , class "border-b text-2xl"
            ]
            [ input
                [ class "mr-3"
                , type_ "checkbox"
                , onCheck (eventHandler index)
                ]
                []
            , text todo.label
            ]
        ]


todoEntry : String -> (String -> msg) -> msg -> Html msg
todoEntry label updateHandler submitHandler =
    div [ class "flex" ]
        [ input
            [ class "flex-grow px-4 py-2"
            , class "border-b-2 border-gray-600"
            , class "text-gray-600 text-2xl"
            , class "outline-none focus:border-blue-400"
            , placeholder "Add Todo"
            , onEnter submitHandler
            , onInput updateHandler
            , value label
            ]
            []

        -- , button [ class "rounded-r bg-gray-600 text-white px-3" ] [ text "Add" ]
        ]


contentContainer : Html msg -> Html msg
contentContainer content =
    div
        [ class "bg-white"
        , class "border border-gray-500 mx-4"
        , class "shadow"
        ]
        [ content ]
