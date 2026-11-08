module Content.Clues exposing (clue)

{-| Every inspectable clue. Text that depends on history reads the World:

  - HubProp text follows premises / tradition / onlineService.
  - ShadowScript and StageSketch follow scriptVariant.
  - RuthsEmail and InscriptionClue follow inscriptionSource.

Each variant carries every fact its puzzle needs. Clues state facts; none
says whether an arrangement is right.

-}

import Content.Mystery as Mystery
import Domain exposing (BookTab(..), CandidateId(..), ClueId(..), Document, Foundation(..), HubProp(..), InscriptionSource(..), ScriptVariant(..), World)
import Rules.Repair


clue : World -> ClueId -> Document
clue world clueId =
    case clueId of
        -- Introduction
        ClosureNotice ->
            { title = "Kapanış ilanı"
            , paragraphs =
                [ "Dört kuşaktan sonra Hale Kitabevi, bu Noel arifesinde kapılarını son kez kapatıyor."
                , "Soğuktan kaçıp içeri giren herkese teşekkürler."
                ]
            }

        FamilyPhotograph ->
            { title = "Aile fotoğrafı"
            , paragraphs =
                [ "Ahşap çerçevede, dükkânın önünde çekilmiş bir fotoğraf: bastonuyla Walter Dede, yanında Henry ve önde, güneşe karşı gözlerini kısmış küçük Edwin."
                , "Altında yazıyor: “Walter Dede, babam ve ben.”"
                ]
                    ++ (if world.tradition /= NotRevisited then
                            [ "1973’teki gölge oyununun ardından düştüğü geceden beri camı çatlak ve eski bantlarla bir arada duruyor." ]

                        else
                            []
                       )
            }

        -- Present hub
        HubProp prop ->
            hubProp world prop

        -- 1950 repair board
        WalterDiaryPage ->
            { title = "Walter’ın günlüğü"
            , paragraphs =
                [ "“Bütün hafta için dört tahta ve 10 sterlin. Hepsini yeniden açılış için gösterişli yeni bir tabelaya harcadım. Harika görünüyordu. Sonra çarşamba yağmuru çatıdan girip kurtardığımız bütün kitapların üstüne yağdı.”"
                ]
            }

        GlassDeliverySlip ->
            { title = "Cam teslim fişi"
            , paragraphs =
                [ "Hale Kitabevi için bir adet pencere camı."
                , "Teslimat: çarşamba sabahı. Hafta içinde daha erken mümkün değil."
                ]
            }

        RubbleAndShelvesNote ->
            { title = "Walter’ın tamir notları"
            , paragraphs =
                [ "Yeni raflar şu an molozun olduğu yere kurulacak, bu yüzden önce moloz temizlenmeli."
                , "Konacak raf olana kadar kitaplar sandıklarında kalır."
                ]
            }

        BudgetAllocation ->
            { title = "Tahta ve para"
            , paragraphs =
                [ "Bütün hafta için: "
                    ++ String.fromInt Rules.Repair.budget.timber
                    ++ " tahta ve £"
                    ++ String.fromInt Rules.Repair.budget.pounds
                    ++ "."
                , "Bu hafta yapılan her iş bundan karşılanır. Artan kısım harcanmadan kalabilir."
                ]
            }

        -- 1950 reopening shelf
        ShelfPlaque ->
            { title = "Bu kitapları düzenle."
            , paragraphs = [ "İpucu: Onları düzenlemenin dört farklı yolu var." ]
            }

        -- 1973
        ShadowScript ->
            shadowScript world.scriptVariant

        StageSketch ->
            stageSketch world.scriptVariant

        CutoutBox ->
            { title = "Kesik figür kutusu"
            , paragraphs =
                [ "Altı karton figür: bir tilki, bir baykuş ve bir çocuk; bir fener, bir anahtar ve bir kitap."
                , "Her sahneye bir karakter ve bir eşya gerekir. Her figür bir kez kullanılır."
                ]
            }

        -- 1998
        RuthsEmail ->
            ruthsEmail world.inscriptionSource

        RememberedSentence ->
            { title = "Akılda kalan bir satır"
            , paragraphs =
                [ "Ruth, Lucy’nin kitaptan bir satırı hâlâ ezbere söyleyebildiğini ekliyor:"
                , "“Fener, son yolcu eve dönene kadar yanık kaldı.”"
                ]
            }

        InscriptionClue ->
            inscription world.inscriptionSource

        CandidatePage candidateId tab ->
            candidatePage candidateId tab



-- PRESENT HUB


hubProp : World -> HubProp -> Document
hubProp world prop =
    case prop of
        RoofAndShelves ->
            { title = "Çatı ve raflar"
            , paragraphs =
                [ case world.premises of
                    NotRevisited ->
                        "1950’den beri tavana kahverengi bir su lekesi yayılmış. Raflar eğilmiş, arka odadaki arşiv rutubet kokuyor."

                    Missing ->
                        "1950’deki tamirler hiçbir zaman tam tutmadı. Tavan lekeli, raflar derme çatma ve arka odadaki eski arşivi rutubet çoktan yok etti."

                    Established ->
                        "Walter’ın 1950’de yamaladığı çatı hâlâ sağlam. Rafları dimdik duruyor, arka odadaki arşiv kuru ve dolu."
                ]
            }

        CommunityWall ->
            { title = "Mahalle duvarı"
            , paragraphs =
                [ case world.tradition of
                    NotRevisited ->
                        "Çocuk köşesinin yanında çıplak bir duvar parçası. Birkaç eski raptiye deliği, asılı hiçbir şey yok. Dükkân Noel okumalarını çok uzun zaman önce bıraktı."

                    Missing ->
                        "Solmuş tek bir afiş: “Noel Okuması, 1973.” Ondan sonra hiçbir şey yok. Gölge oyunu bir daha hiç denenmedi."

                    Established ->
                        "Onlarca yılın Noel gölge oyunu afişleri, çocukların çizdiği fenerli tilkiler ve 1973’ten, ön sırada küçük Lucy’yle Ruth’un bir fotoğrafı."
                ]
            }

        OrderDesk ->
            { title = "Sipariş masası"
            , paragraphs =
                [ case world.onlineService of
                    NotRevisited ->
                        "Boş bir masa ve eski bir bilgisayar. Ne paket var ne sipariş. Dükkân kendi kapısının ötesine tek bir kitap bile satmadı."

                    Missing ->
                        "Çekmecede, 1998’den, bir türlü bulunamamış bir kitapla ilgili basılı tek bir e-posta. Bekleyen paket yok."

                    Established ->
                        "Üç ülkeye paket etiketleri, siparişlerle dolu bir yazıcı ve 1998’den çerçevelenmiş ilk e-posta: “Lucy’nin kitabını buldunuz!”"
                ]
            }



-- 1973


shadowScript : ScriptVariant -> Document
shadowScript variant =
    case variant of
        OriginalScript ->
            { title = "Gölge oyunu metni"
            , paragraphs =
                [ "Walter’ın metni, 1950’den beri arka odada kuru tutulmuş. Roller:"
                , "Herkes evdeyken çocuk kitabı açar."
                , "Tilki feneri köprünün öbür yanına taşır."
                , "Baykuş kapıda anahtarı kullanır."
                ]
            }

        NeighboursRetelling ->
            { title = "Komşuların anlatımı"
            , paragraphs =
                [ "Walter’ın metni kayboldu, bu yüzden komşular hikâyeyi hatırladıkları gibi yazdılar. Roller:"
                , "Çocuk anahtarı bahçe kapısında bulur."
                , "Tilki herkese eve giden yolu göstermek için feneri taşır."
                , "Baykuş içeride kitabı okur."
                ]
            }


stageSketch : ScriptVariant -> Document
stageSketch variant =
    case variant of
        OriginalScript ->
            { title = "Sahne taslağı"
            , paragraphs =
                [ "Kurşun kalemle numaralanmış üç bölme:"
                , "1. Sahne: köprü. 2. Sahne: kapı. 3. Sahne: ev."
                ]
            }

        NeighboursRetelling ->
            { title = "Sahne taslağı"
            , paragraphs =
                [ "Kurşun kalemle numaralanmış üç bölme:"
                , "1. Sahne: bahçe kapısı. 2. Sahne: içeride. 3. Sahne: ev."
                ]
            }



-- 1998


ruthsEmail : InscriptionSource -> Document
ruthsEmail source =
    case source of
        FamilyArchive ->
            { title = "Ruth’tan e-posta"
            , paragraphs =
                [ "Sevgili Hale ailesi, yıllar önce Lucy’nin kitaplarını size vermiştik. Hâlâ 1973’teki gölge oyununuzdan bahsediyor."
                , "En sevdiği kitapta taş bir köprünün altında fener taşıyan bir tilki vardı. Bu Noel kızı için o nüshayı bulabilir misiniz? Ruth"
                ]
            }

        FollowUpEmail ->
            { title = "Ruth’tan e-posta"
            , paragraphs =
                [ "Sevgili Hale ailesi, yıllar önce Lucy’nin kitaplarını size vermiştik."
                , "En sevdiği kitapta taş bir köprünün altında fener taşıyan bir tilki vardı. Bu Noel kızı için o nüshayı bulabilir misiniz? Ruth"
                ]
            }


inscription : InscriptionSource -> Document
inscription source =
    case source of
        FamilyArchive ->
            { title = "1973 gölge oyunundan bir fotoğraf"
            , paragraphs =
                [ "Dükkânın arşivinden: ön sırada Ruth ve Lucy."
                , "Arkasında Henry’nin notu: “Ruth, kızına verdiği her kitaba ‘Lucy’ye, sevgilerle, Annen’ yazar.”"
                ]
            }

        FollowUpEmail ->
            { title = "Ruth’un ikinci e-postası"
            , paragraphs =
                [ "Söylemeyi unuttum: bütün kitaplarına yaptığım gibi ön kapağın içine “Lucy’ye, sevgilerle, Annen.” yazmıştım. Ruth"
                ]
            }


candidatePage : CandidateId -> BookTab -> Document
candidatePage candidateId tab =
    let
        content =
            Mystery.candidate candidateId
    in
    case tab of
        CoverTab ->
            { title = content.label ++ ": kapak ve resim", paragraphs = [ content.cover ] }

        TextTab ->
            { title = content.label ++ ": metin", paragraphs = [ content.text ] }

        DedicationTab ->
            { title = content.label ++ ": ithaf", paragraphs = [ content.dedication ] }
