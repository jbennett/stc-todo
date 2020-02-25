module Views exposing (contentContainer, footer, masthead, todoEntry, todosList)

import Array exposing (Array)
import Data exposing (Todo, Todos)
import Helpers exposing (onEnter)
import Html exposing (Html, div, h1, input, label, text)
import Html.Attributes exposing (class, placeholder, type_, value)
import Html.Events exposing (onCheck, onInput)


masthead : Html msg
masthead =
    h1 [] [ text "Elm Todo" ]


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


todoRow : Int -> (Int -> Bool -> msg) -> Todo -> Html msg
todoRow index eventHandler todo =
    div []
        [ label [ class "text-2xl" ]
            [ input [ type_ "checkbox", onCheck (eventHandler index) ] []
            , text <| String.fromInt index ++ ". " ++ todo.label
            ]
        ]


todoEntry : String -> (String -> msg) -> msg -> Html msg
todoEntry label updateHandler submitHandler =
    div [ class "flex" ]
        [ input
            [ class "flex-grow px-2 py-2"
            , class "border-2 border-gray-600"
            , class "rounded"
            , class "text-gray-600"
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
    div [ class "mx-12 my-3" ] [ content ]
