module Content.Repair exposing (goal, taskCard)

{-| Words on the 1950 repair board. Costs are never written here: they come
from Rules.Repair.cost. Notes restate each card's own rule; none says which
cards to leave out.
-}

import Domain exposing (ReopeningGoal(..), TaskCardContent, TaskId(..))


taskCard : TaskId -> TaskCardContent
taskCard task =
    case task of
        PatchRoof ->
            { title = "Çatıyı yamala"
            , note = "Çarşamba yağmurundan önce yapılmalı."
            }

        ClearRubble ->
            { title = "Molozu temizle"
            , note = "Yeni raflar şu an molozun olduğu yere kurulacak."
            }

        BuildShelves ->
            { title = "Raf yap"
            , note = "Ancak moloz temizlendikten sonra. Kitaplar bunları bekliyor."
            }

        ShelveBooks ->
            { title = "Kitapları rafa diz"
            , note = "Ancak yeni raflar yapıldıktan sonra."
            }

        ReglazeWindow ->
            { title = "Pencereye cam tak"
            , note = "Yeni cam çarşamba günü teslim ediliyor."
            }

        PaintSign ->
            { title = "Gösterişli yeni bir tabela boya"
            , note = "Açılış günü herkesin gözünü alacak bir şey."
            }

        BoardUpWindow ->
            { title = "Pencereyi tahtayla kapat"
            , note = "Kırık pencereyi tahtalarla kapatır."
            }


goal : ReopeningGoal -> String
goal reopeningGoal =
    case reopeningGoal of
        WatertightRoof ->
            "Su geçirmeyen bir çatı"

        SealedWindow ->
            "Kapatılmış bir pencere"

        UsableShelves ->
            "Kullanılabilir raflar"

        AllBooksShelved ->
            "Kurtarılan her kitap rafta"
