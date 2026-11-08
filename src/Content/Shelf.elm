module Content.Shelf exposing (matched)

{-| Celebration line once the reopening shelf matches one of the three orders. -}

import Domain exposing (ShelfOrder(..))


matched : ShelfOrder -> String
matched order =
    case order of
        ByHeight ->
            "Kısadan uzuna, yokuş yukarı basamaklar gibi. Raf yeniden açılışa hazır."

        TallToSmall ->
            "Uzundan kısaya, yokuş aşağı basamaklar gibi. Raf yeniden açılışa hazır."

        ByColour ->
            "Kırmızıdan mora, rafın baştan başa bir gökkuşağı. Raf yeniden açılışa hazır."

        Alphabetical ->
            "A’dan Z’ye, katalog gibi düzenli. Raf yeniden açılışa hazır."
