module Helpers exposing (onEnter)

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
