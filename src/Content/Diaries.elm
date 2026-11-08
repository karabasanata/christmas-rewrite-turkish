module Content.Diaries exposing (passage)

{-| Diary passages read in the present. Each era has an original version
(NotRevisited, the history Edwin starts with) and versions for a replayed
chapter that failed or succeeded. Later diaries mention earlier outcomes.

Variants follow Timeline.deriveWorld: an unrevisited earlier chapter counts as
the original, failed history.

-}

import Domain exposing (Document, Era(..), Foundation(..), World)


passage : World -> Era -> Document
passage world era =
    case era of
        Repairs1950 ->
            { title = "Walter’ın günlüğü, 1950"
            , paragraphs = walter world.premises
            }

        Shadows1973 ->
            { title = "Henry’nin günlüğü, 1973"
            , paragraphs = [ henry world.tradition, henryScript world.premises ]
            }

        Search1998 ->
            { title = "Edwin’in defteri, 1998"
            , paragraphs = [ edwin world.onlineService, edwinReading world.tradition ]
            }



-- 1950


walter : Foundation -> List String
walter premises =
    case premises of
        NotRevisited ->
            [ "Noel Arifesi, 1950. Savaş biteli beş yıl oldu ve dükkân hâlâ darmadağın. Tahta izni sonunda çıktı. Bütün hafta için dört tahta ve 10 sterlin. Hepsini yeniden açılış için gösterişli yeni bir tabelaya harcadım. Harika görünüyordu. Sonra çarşamba yağmuru çatıdan girip kurtardığımız bütün kitapların üstüne yağdı."
            , "Daha çok vaktimiz var sanmıştım."
            ]

        Missing ->
            [ "Noel Arifesi, 1950. Savaş biteli beş yıl oldu ve dükkân hâlâ olması gerektiği gibi değil. Bütün hafta için dört tahta ve 10 sterlin. Her gününü planladım, yine de bir iş ötekine dolandı. Cumartesi yarı hazır açtık ve rutubet, eski kâğıtların durduğu arka odaya sızdı."
            , "Daha çok vaktimiz var sanmıştım."
            ]

        Established ->
            [ "Noel Arifesi, 1950. Savaş biteli beş yıl oldu ve dükkân sonunda dükkâna benziyor. Bütün hafta için dört tahta ve 10 sterlin, ben de onları önemli olana harcadım. Çatı çarşamba yağmurundan önce yamandı ve kitaplara tek damla değmedi. Yeni raflar, sapasağlam bir pencere ve kurtardığımız her kitap ait olduğu yerde."
            , "Tabela bekleyebilir. Meğer vaktimiz varmış."
            ]



-- 1973


henry : Foundation -> String
henry tradition =
    case tradition of
        NotRevisited ->
            "Noel Arifesi, 1973. Yine elektrik kesintisi. Çocuk okumasının ortasında ışıklar gitti ve herkesi evine gönderdim. Karanlıkta ne yapabilirdik ki? Ruth küçük kızı Lucy’yi getirmişti. Gidişlerini izledim. Daha çok vaktimiz var sanmıştım."

        Missing ->
            "Noel Arifesi, 1973. Okuma sırasında ışıklar gitti, biz de bir el feneri ve bir çarşafla gölge oyunu denedik. Sahneler karman çorman oldu ve aileler birer birer evlerine dağıldı. Ruth ile Lucy nezaketen sonuna kadar kaldılar. Bir daha hiç denemedik."

        Established ->
            "Noel Arifesi, 1973. Okuma sırasında ışıklar gitti, biz de bir el feneri, bir çarşaf ve biraz kartondan sahne yaptık. Sahne sahne hikâye canlandı. Kimse erken gitmedi. Ruth’un küçük kızı Lucy, seneye yine yapıp yapamayacağımızı sordu. Yapacağız."


henryScript : Foundation -> String
henryScript premises =
    case premises of
        Established ->
            "Babamın çatısı 1950’den beri arka odayı kuru tuttu, bu yüzden onun eski gölge oyunu metni teneke kutusunda hâlâ sağlam."

        _ ->
            "Babamın eski gölge oyunu metni 1950’den sonra rutubetten mahvoldu. Komşular hikâyeyi hâlâ biliyor, gerçi kendi bildikleri gibi anlatıyorlar."



-- 1998


edwin : Foundation -> String
edwin onlineService =
    case onlineService of
        NotRevisited ->
            "Aralık 1998. Herkes internetin bizim gibi dükkânların sonunu getireceğini söylüyor. Belki haklılar. Bugün bir e-postada bizden belirli eski bir kitabı bulmamız istendi. Aramak günler sürerdi, ben de cevapsız bıraktım. Daha çok vaktimiz var sanmıştım."

        Missing ->
            "Aralık 1998. Ruth, kızı Lucy’nin bir zamanlar çok sevdiği bir kitabı bulmamızı istedi. Rafları aradım ve bir tane gönderdim; yanlış nüshaydı. Ruth nazik bir cevap yazdı. Bir daha aramayı teklif etmedim ve fikir orada kaldı."

        Established ->
            "Aralık 1998. Ruth, kızı Lucy’nin bir zamanlar çok sevdiği bir kitabı bulmamızı istedi ve bulduk: doğru resim, doğru satır, doğru ithaf. Ertesi gün babamla internete bir sayfa koyduk. E-postalar o günden beri durmadı."


edwinReading : Foundation -> String
edwinReading tradition =
    case tradition of
        Established ->
            "Babam 1973’ten beri olduğu gibi her Noel gölge oyununu hâlâ sahneliyor. Kasabanın yarısı onunla büyüdü."

        _ ->
            "1973’te ışıkların gittiği o geceden beri burada hiç Noel okuması yapılmadı ve çocuk köşesi artık bir depo."
