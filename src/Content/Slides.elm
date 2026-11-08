module Content.Slides exposing (slide)

{-| Slideshow text after a chapter resolves (see Timeline.slides).

  - WeekdaySlide: one per day of a successful 1950 week, in submitted order.
    Wednesday always adds the rain. Every TaskId is covered, though only the
    five essential jobs appear in a valid week.
  - ReopeningSaturday, PerformanceSlide, ServiceFoundedSlide: success.
  - ConsequenceSlide: the first recorded violation of a failed chapter.

-}

import Content.Shadow as Shadow
import Content.Words exposing (dayName, sceneName)
import Domain exposing (Day(..), Document, Era(..), ReopeningGoal(..), RememberedDetail(..), Scene(..), Slide(..), TaskId(..), Violation(..), World)


slide : World -> Slide -> Document
slide world shown =
    case shown of
        WeekdaySlide day task ->
            { title = dayName day
            , paragraphs =
                weekday day task
                    :: (if day == Wednesday then
                            [ "Öğleden sonra yağmur bastırıyor, sert ve soğuk. Çatı dayanıyor. Kitaplara tek damla değmiyor." ]

                        else
                            []
                       )
            }

        ReopeningSaturday ->
            { title = "Cumartesi: yeniden açılış günü"
            , paragraphs =
                [ "Kapı dokuzda açılıyor. Komşular soğuktan içeri giriyor; kuru bir çatı, sapasağlam bir pencere ve dolu raflar onları karşılıyor."
                , "Gazeteden gelen bir adam, pencere kenarındaki oturakta elinde kitapla kıvrılmış Ruth adında küçük bir kızın fotoğrafını çekiyor."
                , "O gece Walter şunu yazıyor: tam yetecek kadar vaktimiz varmış."
                ]
            }

        PerformanceSlide scene _ ->
            { title = sceneName scene ++ ": " ++ (Shadow.scene world.scriptVariant scene).setting
            , paragraphs =
                (Shadow.scene world.scriptVariant scene).caption
                    :: (if scene == Scene3 then
                            [ "El feneri tık diye sönüyor. Karanlıkta çocuklar alkışlıyor ve Ruth’un kızı Lucy, gelecek Noel yine yapıp yapamayacaklarını soruyor. Henry yapacaklarına söz veriyor." ]

                        else
                            []
                       )
            }

        ServiceFoundedSlide ->
            { title = "Lucy’nin kitabı"
            , paragraphs =
                [ "Paket Noel’e yetişip Ruth’a ulaşıyor. Lucy annesinin el yazısını hemen tanıyor."
                , "Yeni yılda Henry ile Edwin internete bir sayfa koyuyor: hatırladığınız kitabı söyleyin, biz bulalım. İlk siparişler bir hafta içinde geliyor."
                ]
            }

        ConsequenceSlide era broken ->
            consequence era broken



-- 1950 WEEK


weekday : Day -> TaskId -> String
weekday day task =
    case task of
        PatchRoof ->
            "Walter çatıdaki deliğin üstüne tahtaları çakıyor. Akşama doğru sımsıkı yamanmış oluyor."

        ClearRubble ->
            "El arabası el arabası moloz arka kapıdan çıkıyor. Sonunda zemin temiz."

        BuildShelves ->
            "Eskiden molozun olduğu yere dimdik ve sağlam yeni raflar kuruluyor."

        ShelveBooks ->
            "Rafa dizme günü. Kurtarılan kitaplar sandıklarından çıkıyor, yeni yuvalarına hazır."

        ReglazeWindow ->
            if day == Wednesday then
                "Cam bu sabah geliyor ve öğlene kadar pencere yeniden bütün."

            else
                "Çarşamba teslim edilen cam pencereye takılıyor. Artık cereyan yok."

        PaintSign ->
            "Walter dükkânın önü için gösterişli yeni bir tabela boyuyor."

        BoardUpWindow ->
            "Kırık pencerenin üstüne tahtalar çakılıyor. Güzel durmuyor ama havayı dışarıda tutuyor."



-- FAILURE CONSEQUENCES


consequence : Era -> Violation -> Document
consequence era broken =
    case era of
        Repairs1950 ->
            { title = "Hafta ters gidiyor"
            , paragraphs =
                [ repairConsequence broken
                , "Cumartesi dükkân yarı hazır açılıyor. Rutubet, ailenin eski kâğıtlarının durduğu arka odaya sızıyor."
                ]
            }

        Shadows1973 ->
            { title = "Işıklar gelmiyor"
            , paragraphs =
                [ case broken of
                    SceneConflictsWithScript scene ->
                        sceneName scene ++ " hikâyeye uymuyor ve çocuklar hikâyenin ipini kaçırıyor. Aileler birer birer karanlığın içinden evlerine dönüyor."

                    _ ->
                        "Sahneler hikâyeye uymuyor ve çocuklar hikâyenin ipini kaçırıyor. Aileler birer birer karanlığın içinden evlerine dönüyor."
                , "Ertesi Noel de, ondan sonraki de gölge oyunu yok."
                ]
            }

        Search1998 ->
            { title = "Yanlış nüsha"
            , paragraphs =
                [ case broken of
                    DetailDoesNotMatch FoxLanternIllustration ->
                        "Paket Ruth’a ulaşıyor ama içindeki tilki köprünün altında değil, bir ormanda yürüyor. Bu Lucy’nin nüshası değil."

                    DetailDoesNotMatch LanternSentence ->
                        "Paket Ruth’a ulaşıyor ama Lucy’nin hatırladığı satır içinde yok. Bu Lucy’nin nüshası değil."

                    DetailDoesNotMatch LucyInscription ->
                        "Paket Ruth’a ulaşıyor ama ithaf başka birine yazılmış. Bu Lucy’nin nüshası değil."

                    _ ->
                        "Paket Ruth’a ulaşıyor ama bu Lucy’nin nüshası değil."
                , "Ruth nazik bir teşekkür yazıyor. İnsanlar için kayıp kitapları bulma fikri orada kalıyor."
                ]
            }


repairConsequence : Violation -> String
repairConsequence broken =
    case broken of
        RoofAfterRain day ->
            "Çarşamba yağmuru çatıdan kurtarılan kitapların üstüne boşalıyor. Çatıyı " ++ dayName day ++ " günü yamamak için çok geç."

        GoalMissing WatertightRoof ->
            "Çarşamba yağmuru yamanmamış çatıdan kurtarılan kitapların üstüne boşalıyor."

        GlassNotYetDelivered day ->
            dayName day ++ " günü takılacak cam yok. Pencere açık duruyor ve rüzgâr yağmuru içeri savuruyor."

        GoalMissing SealedWindow ->
            "Kırık pencere hiç kapatılmıyor. Bütün hafta rüzgâr yağmuru içeri savuruyor."

        MustComeBefore ClearRubble BuildShelves ->
            "Moloz hâlâ oradayken raflar kurulamıyor. Tahtalar kullanılmadan yerde yatıyor."

        GoalMissing UsableShelves ->
            "Hiç raf kurulmuyor, bu yüzden kurtarılan kitaplar rutubetli sandıklarda yığılı kalıyor."

        MustComeBefore BuildShelves ShelveBooks ->
            "Rafa dizme gününde henüz raf yok. Kitaplar yerde rutubetli yığınlar hâlinde kalıyor."

        MustComeBefore _ _ ->
            "İşler yanlış sırayla geliyor ve biri, öteki bitmeden başlayamıyor."

        GoalMissing AllBooksShelved ->
            "Kurtarılan kitaplar sandıklarından hiç çıkmıyor ve rutubet içlerine işliyor."

        TimberOverspent _ ->
            "Tahtalar hafta ortasında bitiyor ve bir iş yarım kalıyor."

        MoneyOverspent _ ->
            "Para hafta ortasında bitiyor ve bir iş yarım kalıyor."

        SceneConflictsWithScript _ ->
            "Hafta plana göre gitmiyor."

        DetailDoesNotMatch _ ->
            "Hafta plana göre gitmiyor."
