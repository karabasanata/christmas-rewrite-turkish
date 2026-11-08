module Views.Salvage exposing (view)

{-| 1950 warm-up: nine books into three crates. Forgiving, so it is allowed to
show correctness straight away, unlike the repair board.
-}

import Components.Art as Art
import Components.Placement as PlacementUI
import Content.Books
import Domain exposing (..)
import Html exposing (Html, button, div, section, span, text)
import Html.Attributes exposing (attribute, class, classList, disabled, type_)
import Html.Events exposing (onClick)
import Rules.Books
import Rules.Placement
import Rules.Salvage
import Views.Common as Common


view : List BookId -> Placement BookId SalvageSlot -> Maybe Notice -> List (Html Msg)
view books placement notice =
    let
        config =
            placementConfig books placement
    in
    [ div [ class "salvage-scene" ]
        [ Common.topbar "1950"
            "Kitapları Kurtar"
            (Common.helpButton "Sandıklara dön"
                [ "Bir kitabı almak için üstüne tıkla, sonra koymak için bir sandığa tıkla. Yeniden taşımak için sandıktaki bir kitaba tıkla."
                , "Nereye ait olduğuna karar vermek için her kitabın hasarına bak. Hatalarını istediğin kadar düzeltebilirsin."
                , "Her sandığa üç kitap gider. Hepsi ayrıldığında Devam et’e bas."
                ]
                ++ [ Common.closePanel True ]
            )
        , div [ class "crates" ]
            [ crate config Fine "Sağlam" "Hiç hasar yok"
            , crate config NeedsRepair "Tamir edilebilir" "Yalnızca duman ya da su hasarı"
            , crate config TooFarGone "Kurtarılamaz" "Yanmış ya da sayfaları eksik"
            ]
        , PlacementUI.tray config
        , div [ class "scene-foot" ]
            [ Common.statusLine notice (progress placement)
            , Common.primaryButton [ onClick Advance ] "Devam et"
            ]
        ]
    ]


{-| No per-book marks: the player is told how many books are misplaced, not which. -}
placementConfig : List BookId -> Placement BookId SalvageSlot -> PlacementUI.Config BookId SalvageSlot Msg
placementConfig books placement =
    { toMsg = SalvageMove
    , enabled = True
    , placement = placement
    , items = books
    , name = \book -> (Content.Books.book book).title
    , cardClass = \_ -> "book--art"
    , cardBody = bookBody
    , marks = \_ -> []
    }


crate : PlacementUI.Config BookId SalvageSlot Msg -> Condition -> String -> String -> Html Msg
crate config condition name description =
    let
        slots =
            Rules.Salvage.crateSlots condition

        holding =
            config.placement.selected /= Nothing
    in
    section [ classList [ ( "crate", True ), ( "is-target", holding ) ], attribute "aria-label" (name ++ " sandığı") ]
        [ button
            [ type_ "button"
            , class "crate__label"
            , disabled (not holding)
            , onClick (SalvageMove (PlaceSelectedInGroup slots))
            ]
            [ span [ class "crate__name" ] [ text name ]
            , span [ class "crate__description" ] [ text description ]
            ]
        , div [ class "crate__slots" ] (List.map (PlacementUI.group config (name ++ " sandığı") slots) slots)
        ]


{-| Says how many books are in the wrong crate, never which ones. -}
progress : Placement BookId SalvageSlot -> String
progress placement =
    let
        unsorted =
            List.length (Rules.Placement.inTray Rules.Books.allBooks placement)

        title book =
            "“" ++ (Content.Books.book book).title ++ "”"
    in
    case ( Rules.Salvage.misplaced placement, placement.selected ) of
        ( _ :: [], _ ) ->
            "1 kitap yanlış sandıkta."

        ( _ :: others, _ ) ->
            String.fromInt (List.length others + 1) ++ " kitap yanlış sandıklarda."

        ( [], Just book ) ->
            title book ++ " için bir sandığa tıkla."

        ( [], Nothing ) ->
            if unsorted == 0 then
                "Her kitap doğru sandıkta. Hazır olduğunda devam et."

            else
                String.fromInt unsorted ++ " kitap daha ayrılacak. Bir kitaba tıkla, sonra bir sandığa tıkla."


{-| The cover with its damage drawn on, and the title. Damage isn't written out:
the player reads it from the art.
-}
bookBody : BookId -> List (Html Msg)
bookBody book =
    let
        content =
            Content.Books.book book
    in
    [ Art.bookCover book content.damage
    , span [ class "book__caption" ] [ span [ class "book__title" ] [ text content.title ] ]
    ]
