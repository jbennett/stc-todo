module Main exposing (init, main, update, view)

import Array
import Browser
import Data exposing (Model, Msg(..))
import Helpers
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

getTomatos : Volume -> Weight
getTomatos amount =
    let 
		ratio =
			Quantity.per (Weight.grams 1000) (Volume.liters 1)
	in
		Quantity.times ratio amount

Volume.milliliters 250
	|> getTomatos
	|> Debug.log 
— prints 250 grams


---- UPDATE ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TodoClicked eventIndex checked ->
            let
                targetTodo =
                    Array.get eventIndex model.todos

                updatedTodo =
                    Maybe.map Data.toggleTodo targetTodo

                updatedTodos =
                    Maybe.map2
                        (\todo newTodo ->
                            Data.replaceTodo todo newTodo model.todos
                        )
                        targetTodo
                        updatedTodo
                        |> Maybe.withDefault model.todos
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
                    [ Views.todoEntry model.entryText
                    , Views.todosList model.todos
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
