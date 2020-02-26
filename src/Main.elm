module Main exposing (init, main, update, view)

import Array
import Browser
import Data exposing (Model, Msg(..))
import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Views



---- MODEL ----


init : ( Model, Cmd Msg )
init =
    ( { entryText = ""
      , todos = Data.defaultTodos
      }
    , Cmd.none
    )



---- UPDATE ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TodoClicked eventIndex checked ->
            let
                updatedTodos =
                    model.todos
                        |> Array.indexedMap
                            (\todoIndex todo ->
                                if todoIndex == eventIndex then
                                    Data.toggleTodo todo

                                else
                                    todo
                            )
            in
            ( { model | todos = updatedTodos }, Cmd.none )

        EntryUpdated newLabel ->
            ( { model | entryText = newLabel }, Cmd.none )

        EntrySubmitted ->
            let
                newTodos =
                    if model.entryText /= "" then
                        Array.push (Data.initTodo model.entryText) model.todos

                    else
                        model.todos
            in
            ( { model
                | entryText = ""
                , todos = newTodos
              }
            , Cmd.none
            )

        NoOp ->
            ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div [ class "flex flex-col items-center min-h-screen" ]
        [ div [ class "mt-8 mb-16" ] [ Views.masthead ]
        , div [ class "max-w-screen-md w-full" ]
            [ Views.contentContainer
                (div []
                    [ Views.todoEntry model.entryText EntryUpdated EntrySubmitted
                    , Views.todosList TodoClicked model.todos
                    , Views.todosSummary model.todos
                    ]
                )
            ]
        , div [ class "mt-auto" ] [ Views.footer ]
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
