module Views.BookTable exposing (view)

{-| 1998 main puzzle: four candidate books, presented the same way. Looking
inside a book (its picture, text or dedication) opens a clue sheet. Choosing a
book is a separate button. Nothing here says which book is right: correctness
comes only from puzzle.attempts after "Bu kitabı gönder".
-}

import Components.Art as Art
import Content.Mystery
import Domain exposing (..)
import Html exposing (Html, article, aside, button, div, h3, section, span, text)
import Html.Attributes exposing (attribute, class, classList, disabled, type_)
import Html.Events exposing (onClick)
import Rules.Attempts
import Rules.Mystery
import Views.Common as Common


type alias Puzzle =
    MainPuzzle (Maybe CandidateId)


{-| `order` is the order the four books lie on the table this game
(Rules.BookTrays.candidates, from the run seed).
-}
view : World -> List CandidateId -> Puzzle -> Maybe Notice -> List (Html Msg)
view world order puzzle notice =
    let
        reviewing =
            Common.reviewedViolations puzzle.attempts

        numbered =
            Common.numbered reviewing

        isReviewing =
            not (List.isEmpty reviewing)
    in
    [ div [ classList [ ( "board-scene", True ), ( "table-scene", True ), ( "is-reviewing", isReviewing ) ] ]
        [ Common.topbar "1998"
            "Unutulan Kitap"
            (Common.attemptsDisplayOf (Rules.Attempts.maxAttemptsFor Search1998) puzzle.attempts
                :: Common.lastTryNotes "Kitaplara dön" puzzle.attempts
                ++ help
                ++ [ Common.closePanel (not isReviewing) ]
            )
        , section [ class "book-table", attribute "aria-label" "Dört aday kitap" ]
            (List.map (candidateCard puzzle isReviewing numbered) order)
        , aside [ class "side" ]
            [ div [ class "paper-note" ]
                [ h3 [ class "paper-note__title" ] [ text "Ruth’un isteği" ]
                , div [ class "side-clues" ] (List.map (Common.clueNote world puzzle.inspected) clues)
                ]
            , Common.statusLine notice (hint puzzle isReviewing)
            , Common.primaryButton [ disabled isReviewing, onClick Submit ] "Bu kitabı gönder"
            ]
        , if isReviewing then
            Common.feedback
                { title = "Bu Lucy’nin kitabı değil. Uyuşmayanlar şunlar:"
                , note = "Bir hakkın daha var. Seçimin, sen değiştirene kadar olduğu gibi kalır."
                }
                numbered

          else
            text ""
        ]
    ]


clues : List ClueId
clues =
    [ RuthsEmail, RememberedSentence, InscriptionClue ]


help : List (Html Msg)
help =
    Common.helpButton "Kitaplara dön"
        [ "Her kitabın içine bak: resmine, metnine ve kapağın içindeki el yazısı nota. Bakmak hiçbir hak harcamaz."
        , "Ruth’un e-postasını ve yanındaki notları istediğin kadar oku."
        , "Lucy’nin olduğunu düşündüğün kitabı seç, sonra Bu kitabı gönder’e bas. Tek hakkın var: yanlış kitapsa geri alınamaz."
        ]


{-| Every card has the same parts in the same order, so none stands out. The
chosen card is marked by the player's own choice, never by the rules.
-}
candidateCard : Puzzle -> Bool -> List ( String, Violation ) -> CandidateId -> Html Msg
candidateCard puzzle isReviewing numbered candidate =
    let
        content =
            Content.Mystery.candidate candidate

        isChosen =
            puzzle.arrangement == Just candidate

        marks =
            if isChosen then
                List.map Tuple.first numbered

            else
                []

        tab bookTab label =
            let
                page =
                    CandidatePage candidate bookTab
            in
            button
                [ type_ "button"
                , class "candidate__tab"
                , attribute "aria-label" (label ++ ": " ++ content.label)
                , onClick (Inspect page)
                ]
                (text label
                    :: (if List.member page puzzle.inspected then
                            [ span [ class "clue__read" ] [ text "Oku" ] ]

                        else
                            []
                       )
                )
    in
    article
        [ classList [ ( "candidate", True ), ( "is-chosen", isChosen ), ( "is-flagged", not (List.isEmpty marks) ) ]
        , attribute "aria-label" content.label
        ]
        (List.map (\mark -> span [ class "mark" ] [ text mark ]) marks
            ++ [ Art.candidateCover candidate
               , h3 [ class "candidate__title" ] [ text content.label ]
               , div [ class "candidate__tabs", attribute "role" "group", attribute "aria-label" ("İçine bak: " ++ content.label) ]
                    [ tab CoverTab "Resim"
                    , tab TextTab "Metin"
                    , tab DedicationTab "El yazısı not"
                    ]
               , button
                    [ type_ "button"
                    , class "btn candidate__choose"
                    , attribute "aria-pressed"
                        (if isChosen then
                            "true"

                         else
                            "false"
                        )
                    , disabled isReviewing
                    , onClick (ChooseCandidate candidate)
                    ]
                    [ text
                        (if isChosen then
                            "Seçildi"

                         else
                            "Bu kitabı seç"
                        )
                    ]
               ]
        )


hint : Puzzle -> Bool -> String
hint puzzle isReviewing =
    if isReviewing then
        "Aşağıdaki notları oku, sonra tekrar dene."

    else
        case puzzle.arrangement of
            Just candidate ->
                "“" ++ (Content.Mystery.candidate candidate).label ++ "” seçildi. Emin olduğunda gönder."

            Nothing ->
                "Kitapların içine bak, sonra göndermek için birini seç."
