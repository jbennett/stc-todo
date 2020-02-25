module Main exposing (Model, Msg(..), init, main, update, view)

import Array
import Browser
import Data exposing (Todos)
import Html exposing (Html, div)
import Views



---- MODEL ----


type alias Model =
    { entryText : String
    , todos : Todos
    }


init : ( Model, Cmd Msg )
init =
    ( { entryText = ""
      , todos = Array.fromList [ Data.initTodo "Test", Data.initTodo "Foo" ]
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = TodoClicked Int Bool
    | EntryUpdated String
    | EntrySubmitted
    | NoOp


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
            ( { model
                | entryText = ""
                , todos = Array.push (Data.initTodo model.entryText) model.todos
              }
            , Cmd.none
            )

        NoOp ->
            ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ Views.masthead
        , Views.contentContainer
            (div []
                [ Views.todoEntry model.entryText EntryUpdated EntrySubmitted
                , Views.todosList TodoClicked model.todos
                ]
            )
        , Views.footer
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
