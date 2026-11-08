module Views.Labels exposing (eraYear, yearFrom, yearObject, yearTo)

{-| Short interface labels for IDs. Fixed names, not story text. -}

import Domain exposing (Era(..))


eraYear : Era -> String
eraYear era =
    case era of
        Repairs1950 ->
            "1950"

        Shadows1973 ->
            "1973"

        Search1998 ->
            "1998"


{-| Turkish case endings for the years: "1950’ye" (to), "1950’den" (from),
"1950’yi" (object).
-}
yearTo : Era -> String
yearTo era =
    case era of
        Repairs1950 ->
            "1950’ye"

        Shadows1973 ->
            "1973’e"

        Search1998 ->
            "1998’e"


yearFrom : Era -> String
yearFrom era =
    case era of
        Repairs1950 ->
            "1950’den"

        Shadows1973 ->
            "1973’ten"

        Search1998 ->
            "1998’den"


yearObject : Era -> String
yearObject era =
    case era of
        Repairs1950 ->
            "1950’yi"

        Shadows1973 ->
            "1973’ü"

        Search1998 ->
            "1998’i"
