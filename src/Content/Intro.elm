module Content.Intro exposing (step)

{-| The opening sequence, in short beats (about 120 words across all three steps).
-}

import Domain exposing (Document, IntroStep(..))


step : IntroStep -> Document
step introStep =
    case introStep of
        PackingUp ->
            { title = "Noel Arifesi"
            , paragraphs =
                [ "Pencerede kar. Hale Kitabevi neredeyse bomboş."
                , "Edwin Hale bir koliyi daha bantlıyor. Dört kuşaktan sonra dükkân bu gece temelli kapanıyor."
                , "Kapanış ilanı çoktan vitrine asıldı. Aile fotoğrafı hâlâ duvarda asılı."
                , "Tezgâhın altında tek bir kutu kaldı."
                ]
            }

        DiariesFound ->
            { title = "Üç günlük"
            , paragraphs =
                [ "İçinde üç günlük var."
                , "1950’den Walter’ınki. 1973’ten Henry’ninki. Ve Edwin’in 1998’den kalma, tuttuğunu bile unuttuğu kendi defteri."
                , "Her biri, farklı bir el yazısıyla, aynı şeyi söylüyor: “Daha çok vaktimiz var sanmıştım.”"
                ]
            }

        ClockStopped ->
            { title = "Gece yarısından hemen önce"
            , paragraphs =
                [ "“Bir şans daha, yalnızca bir şans,” diyor Edwin boş dükkâna."
                , "Saat, gece yarısına bir dakika kala duruyor."
                , "Tezgâhın üstünde en eski günlük parlamaya başlıyor."
                ]
            }
