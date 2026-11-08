module Views.Shelf exposing (view)

{-| 1950 celebration: arrange the six recovered books in any accepted order.
Forgiving, so a matched order is celebrated as soon as it appears.
-}

import Components.Art as Art
import Components.Placement as PlacementUI
import Content.Books
import Content.Clues
import Content.Shelf
import Domain exposing (..)
import Html exposing (Html, aside, button, div, h3, p, section, span, text)
import Html.Attributes exposing (attribute, class, type_)
import Html.Events exposing (onClick)
import Rules.Books
import Rules.Shelf
import Views.Common as Common


view : World -> List RecoverableBook -> Placement RecoverableBook ShelfSlot -> Maybe Notice -> List (Html Msg)
view world books placement notice =
    let
        config =
            placementConfig books placement

        matched =
            Rules.Shelf.matchedOrder placement

        plaque =
            Content.Clues.clue world ShelfPlaque

        position index slot =
            PlacementUI.slot config ("Raftaki " ++ String.fromInt (index + 1) ++ ". yer") slot
    in
    [ div [ class "board-scene shelf-scene" ]
        [ Common.topbar "1950"
            "Açılış Rafı"
            (Common.helpButton "Rafa dön"
                [ "Bir kitabı almak için üstüne tıkla, sonra raftaki bir boşluğa tıkla. Yer değiştirmek için dolu bir boşluğa tıkla."
                , "Bu kitapları sıralamanın dört farklı yolu var. Herhangi birini bul. İstediğin kadar yeniden düzenleyebilirsin, hiçbir zaman hak harcamaz."
                ]
                ++ [ Common.closePanel True ]
            )
        , section [ class "shelf", attribute "aria-label" "Açılış rafı" ]
            [ div [ class "shelf__slots" ] (List.indexedMap position Rules.Shelf.slots) ]
        , aside [ class "side" ]
            [ button [ type_ "button", class "paper-note plaque", onClick (Inspect ShelfPlaque) ]
                (h3 [ class "paper-note__title" ] [ text plaque.title ]
                    :: List.map (\line -> p [ class "plaque__line" ] [ text line ]) plaque.paragraphs
                )
            , case matched of
                Just order ->
                    p [ class "celebration", attribute "role" "status" ] [ text (Content.Shelf.matched order) ]

                Nothing ->
                    Common.statusLine notice (hint placement)
            , Common.primaryButton [ onClick Advance ] "Devam et"
            ]
        , PlacementUI.tray config
        ]
    ]


hint : Placement RecoverableBook ShelfSlot -> String
hint placement =
    case placement.selected of
        Just book ->
            "“" ++ (Content.Books.book (Recoverable book)).title ++ "” için bir boşluğa tıkla."

        Nothing ->
            if List.length placement.placed == List.length Rules.Shelf.slots then
                "Raf dolu ama bu henüz dört sıralamadan biri değil."

            else
                "Bir kitaba tıkla, sonra raftaki bir boşluğa tıkla."


placementConfig : List RecoverableBook -> Placement RecoverableBook ShelfSlot -> PlacementUI.Config RecoverableBook ShelfSlot Msg
placementConfig books placement =
    { toMsg = ShelfMove
    , enabled = True
    , placement = placement
    , items = books
    , name = \book -> (Content.Books.book (Recoverable book)).title
    , cardClass = \_ -> "book--art"
    , cardBody = bookBody
    , marks = \_ -> []
    }


{-| Clean covers: the books have been repaired by now. Height is drawn, and the
colour is also named, so it isn't the only signal.
-}
bookBody : RecoverableBook -> List (Html Msg)
bookBody book =
    [ Art.bookCover (Recoverable book) []
    , span [ class "book__caption" ]
        [ span [ class "book__title" ] [ text (Content.Books.book (Recoverable book)).title ]
        , span [ class "book__damage" ] [ text (colourName (Rules.Books.colour book)) ]
        ]
    ]


colourName : CoverColour -> String
colourName colour =
    case colour of
        Red ->
            "Kırmızı"

        Orange ->
            "Turuncu"

        Yellow ->
            "Sarı"

        Green ->
            "Yeşil"

        Blue ->
            "Mavi"

        Violet ->
            "Mor"
