module Content.Shadow exposing (cutoutName, scene)

{-| 1973 shadow-story words. Each variant's settings and captions agree with
the scripts in the brief (section 5); the matching itself is Rules.Shadow.
-}

import Domain exposing (Character(..), Cutout(..), Prop(..), Scene(..), ScriptVariant(..), ShadowSceneContent)


cutoutName : Cutout -> String
cutoutName cutout =
    case cutout of
        CharacterCutout Fox ->
            "Tilki"

        CharacterCutout Owl ->
            "Baykuş"

        CharacterCutout Child ->
            "Çocuk"

        PropCutout Lantern ->
            "Fener"

        PropCutout Key ->
            "Anahtar"

        PropCutout Book ->
            "Kitap"


{-| `setting` labels a stage panel (it repeats the stage sketch, not the
script). `caption` is read during the successful performance.
-}
scene : ScriptVariant -> Scene -> ShadowSceneContent
scene variant sceneId =
    case ( variant, sceneId ) of
        ( OriginalScript, Scene1 ) ->
            { setting = "Köprü"
            , caption = "Karanlığın içinden tilki, feneri köprünün öbür yanına taşıyor ve yolu aydınlatıyor."
            }

        ( OriginalScript, Scene2 ) ->
            { setting = "Kapı"
            , caption = "Kapıda baykuş anahtarı çeviriyor ve kapı ardına kadar açılıyor."
            }

        ( OriginalScript, Scene3 ) ->
            { setting = "Ev"
            , caption = "Sonunda herkes evde ve çocuk kitabı açıyor."
            }

        ( NeighboursRetelling, Scene1 ) ->
            { setting = "Bahçe kapısı"
            , caption = "Bahçe kapısında çocuk, karın içine yarı gömülmüş bir anahtar buluyor."
            }

        ( NeighboursRetelling, Scene2 ) ->
            { setting = "İçeride"
            , caption = "İçeride, ateşin başında baykuş kitabı sesli okuyor."
            }

        ( NeighboursRetelling, Scene3 ) ->
            { setting = "Ev"
            , caption = "Tilki feneri kaldırıyor ve herkese eve giden yolu gösteriyor."
            }
