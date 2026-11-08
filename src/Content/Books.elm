module Content.Books exposing (book)

{-| Salvage book titles and visible damage. Damage lists match the agreed
table in public/assets/ASSETS.md: smoke or water can be repaired, scorching
or missing pages cannot. Condition itself lives in Rules.Books.condition.
-}

import Domain exposing (BookContent, BookId(..), Damage(..), RecoverableBook(..), RuinedBook(..))


book : BookId -> BookContent
book bookId =
    case bookId of
        Recoverable AtlasOfSmallPlaces ->
            { title = "Minik Yerler Atlası", damage = [] }

        Recoverable BirdsongForBeginners ->
            { title = "Yeni Başlayanlara Kuş Sesleri", damage = [ SmokeStains ] }

        Recoverable GardensInWinter ->
            { title = "Bahçede Kış", damage = [ WaterStains ] }

        Recoverable LettersFromTheSea ->
            { title = "Denizden Mektuplar", damage = [ WaterStains, SmokeStains ] }

        Recoverable PocketOfWonders ->
            { title = "Cep Dolusu Harikalar", damage = [] }

        Recoverable WinterTales ->
            { title = "Kış Masalları", damage = [] }

        Ruined HarbourTales ->
            { title = "Liman Hikâyeleri", damage = [ ScorchedEdges, MissingPages ] }

        Ruined MountainPaths ->
            { title = "Dağ Yolları", damage = [ ScorchedEdges ] }

        Ruined WinterAlmanac ->
            { title = "Kış Almanağı", damage = [ MissingPages, WaterStains ] }
