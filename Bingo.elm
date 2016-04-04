module Bingo where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String

--MODEL

newEntry phrase points id =
  { phrase = phrase,
    points = points,
    wasSpoken = False,
    id = id
  }


initialModel =
  { entries =
    [ newEntry "Doing Agile" 200 2,
      newEntry "In the cloud" 300 3
    ] }

--VIEW

title message times =
  message ++ " "
    |> String.toUpper
    |> String.repeat times
    |> String.trimRight
    |> text


pageHeader =
  h1 [ ] [ title "bingo" 3 ]


pageFooter =
  footer [ ]
    [ a [ href "https://weilandia.github.io" ]
        [ text "Nick Weiland" ]
    ]


entryItem entry =
  li [ ]
    [ span [ class "phrase" ] [ text entry.phrase ],
      span [ class "points" ] [ text (toString entry.points) ]
    ]


entryList entries =
  ul [ ] (List.map entryItem entries)


view model =
  div [ id "container" ]
    [ pageHeader,
      entryList model.entries,
      pageFooter ]

--UPDATE

type Action
  = NoOp
  | Sort

update action model =
  case action of
    NoOp ->
      model

    Sort ->
      { model | entries = List.sortBy .points model.entries }

--CONTROLLER

main =
  initialModel
    |> update Sort
    |> view
