module Content.Endings exposing (missing, saved)

{-| The two endings. `saved` when all three foundations hold; otherwise one
`missing` document per failed era (ShopClosed lists them in era order).
Each missing document stands on its own and keeps the shop's good work in view.
-}

import Domain exposing (Document, Era(..))


saved : Document
saved =
    { title = "Bir Noel daha"
    , paragraphs =
        [ "Saat yeniden işlemeye başlıyor. Gece yarısı."
        , "Walter’ın çatısı hâlâ sağlam. Duvar, onlarca yılın gölge oyunu afişleriyle dolu. Sipariş masası yarın gidecek paketlerle yığılı."
        , "Edwin kapıdaki tabelayı AÇIK yüzüne çeviriyor."
        , "Zil çalıyor. Ruth kardan içeri giriyor; artık daha yavaş, yanında Lucy ve elinde tilkili, fenerli bir kitap tutan Lucy’nin kızı."
        , "Meğer vakit varmış."
        ]
    }


missing : Era -> Document
missing era =
    case era of
        Repairs1950 ->
            { title = "Tamir haftası, 1950"
            , paragraphs =
                [ "Çatı ve raflar hiçbir zaman düzgünce onarılmadı ve rutubet aile arşivini yok etti. Hale Kitabevi yıllarca belirsiz bir zeminde ayakta kaldı."
                , "Yine de koca bir kasaba okumayı onun eğri büğrü raflarında öğrendi."
                ]
            }

        Shadows1973 ->
            { title = "Gölge oyunu, 1973"
            , paragraphs =
                [ "Noel gölge oyunu hiçbir zaman gelenek olmadı. Dükkânla birlikte büyüyebilecek çocuklar başka yerlerde büyüdü."
                , "Bazıları hâlâ ışıkların gittiği o geceyi ve deneyen o dükkânı hatırlıyor."
                ]
            }

        Search1998 ->
            { title = "Unutulan kitap, 1998"
            , paragraphs =
                [ "Hale Kitabevi uzaktaki insanlara kitap bulmayı hiç öğrenmedi. Dükkân kendi kapısı kadar küçük kaldı ve sonunda bu yetmedi."
                , "Ruth, Hale Kitabevi’nde birinin denediğini hiç unutmadı."
                ]
            }
