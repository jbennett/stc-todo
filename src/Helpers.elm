module Helpers exposing (onEnter, removeAtIndex)

import Array exposing (Array)
import Html
import Html.Events as Events
import Json.Decode as Json


onEnter : msg -> Html.Attribute msg
onEnter msg =
    let
        isEnterKey keyCode =
            if keyCode == 13 then
                Json.succeed msg

            else
                Json.fail "silent failure :)"
    in
    Events.on "keyup" <|
        Json.andThen isEnterKey Events.keyCode


removeAtIndex : Int -> Array x -> Array x
removeAtIndex index original =
    let
        a1 =
            Array.slice 0 index original

        a2 =
            Array.slice (index + 1) (Array.length original) original
    in
    Array.append a1 a2
