module Content.Frame exposing (arrival, help, hint, mended, notice, pieceName, title)

{-| 1973, after the performance: the broken family photograph (contract v1.7).
In the dark, Henry bumps the wall, the frame falls and its glass breaks. He
fits the pieces back together before going home.
-}

import Domain exposing (Notice(..), Shard(..))


title : String
title =
    "Kırık Çerçeve"


{-| The line under the room while the glass is on the floor. -}
arrival : String
arrival =
    "Gösteriden sonra karanlıkta Henry duvara çarpıyor. Aile fotoğrafı düşüyor ve camı kırılıyor."


help : List String
help =
    [ "Bir cam parçasını almak için üstüne tıkla, sonra çerçevede oturduğu boşluğa tıkla."
    , "Her parçanın kendine ait bir şekli ve boyutu var, bu yüzden yalnızca tek bir boşluğa oturur. İstediğin kadar dene: hiçbir zaman hak harcamaz."
    ]


{-| What to do next, from what is held and how many pieces are in. -}
hint : Maybe Shard -> Int -> String
hint selected placedCount =
    case selected of
        Just _ ->
            "Şimdi bu parçanın oturduğu boşluğa tıkla."

        Nothing ->
            if placedCount == 0 then
                "Bir cam parçasına tıkla, sonra çerçevede oturduğu yere tıkla."

            else
                "Güzel. Sıradaki parçayı al."


{-| Shown when the glass is whole again. -}
mended : String
mended =
    "Cam yeniden bütün. Birkaç şerit bant onu bir arada tutar."


{-| Neutral feedback, in the frame's own words. -}
notice : Notice -> String
notice which =
    case which of
        DoesNotFitThere ->
            "O parçanın şekli o boşluğa uymuyor."

        NotSolvedYet ->
            "Bazı parçalar hâlâ yerde."

        TargetFull ->
            "O boşluk zaten dolu."

        IncompleteSubmission ->
            "Bazı parçalar hâlâ yerde."


pieceName : Shard -> String
pieceName (Shard n) =
    "Cam parçası " ++ String.fromInt n
