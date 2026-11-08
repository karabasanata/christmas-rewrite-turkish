module Content.Words exposing (dayName, sceneName)

{-| Small wording helpers shared by the Content modules. Words only, no rules.
-}

import Domain exposing (Day(..), Scene(..))


dayName : Day -> String
dayName day =
    case day of
        Monday ->
            "Pazartesi"

        Tuesday ->
            "Salı"

        Wednesday ->
            "Çarşamba"

        Thursday ->
            "Perşembe"

        Friday ->
            "Cuma"


sceneName : Scene -> String
sceneName scene =
    case scene of
        Scene1 ->
            "1. Sahne"

        Scene2 ->
            "2. Sahne"

        Scene3 ->
            "3. Sahne"
