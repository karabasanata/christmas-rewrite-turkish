module Content.Feedback exposing (notice, violation)

{-| One sentence per broken rule, shown only after a submission. Each names
the rule that was broken, never the full answer. Numbers come from
Rules.Repair.budget so they cannot disagree with the rules.
-}

import Content.Repair as Repair
import Content.Words exposing (dayName, sceneName)
import Domain exposing (Day(..), Notice(..), ReopeningGoal(..), RememberedDetail(..), TaskId(..), Violation(..))
import Rules.Repair


violation : Violation -> String
violation broken =
    case broken of
        RoofAfterRain Wednesday ->
            "Çatı çarşamba günü yamanıyor ama yağmur da aynı gün geliyor."

        RoofAfterRain day ->
            "Çarşamba yağmuru, çatı " ++ dayName day ++ " günü yamanmadan önce geliyor."

        GlassNotYetDelivered day ->
            "Yeni cam çarşambadan önce teslim edilmiyor, bu yüzden " ++ dayName day ++ " günü takılamaz."

        MustComeBefore ClearRubble BuildShelves ->
            "Raflar molozun olduğu yere kurulacak, bu yüzden moloz daha önceki bir gün temizlenmeli."

        MustComeBefore BuildShelves ShelveBooks ->
            "Kitapların duracak bir yere ihtiyacı var, bu yüzden raflar daha önceki bir gün yapılmalı."

        MustComeBefore first second ->
            "“" ++ (Repair.taskCard first).title ++ "” işi, “" ++ (Repair.taskCard second).title ++ "” işinden daha önceki bir gün yapılmalı."

        TimberOverspent total ->
            "Bu hafta " ++ String.fromInt total ++ " tahta kullanılıyor ama izin yalnızca " ++ String.fromInt Rules.Repair.budget.timber ++ " tahta için."

        MoneyOverspent total ->
            "Bu hafta £" ++ String.fromInt total ++ " tutuyor ama harcanacak yalnızca £" ++ String.fromInt Rules.Repair.budget.pounds ++ " var."

        GoalMissing WatertightRoof ->
            "Çatı başka bir haftaya bırakılıyor, bu yüzden dükkân su geçirmez şekilde yeniden açılamaz."

        GoalMissing SealedWindow ->
            "Bu hafta yapılan hiçbir iş kırık pencereyi kapatmıyor."

        GoalMissing UsableShelves ->
            "Bu hafta hiç raf yapılmıyor, bu yüzden kitapların gidecek yeri yok."

        GoalMissing AllBooksShelved ->
            "Kurtarılan kitaplar bu hafta hiç rafa dizilmiyor."

        SceneConflictsWithScript scene ->
            sceneName scene ++ ", hikâyede orada olanla uyuşmuyor."

        DetailDoesNotMatch FoxLanternIllustration ->
            "Bu kitabın resmi, taş bir köprünün altında fener taşıyan tilki değil."

        DetailDoesNotMatch LanternSentence ->
            "Bu kitapta Lucy’nin hatırladığı satır yok."

        DetailDoesNotMatch LucyInscription ->
            "Bu kitaptaki ithaf, Ruth’un yazdığı ithaf değil."


{-| Neutral messages. None of them says anything about correctness. -}
notice : Notice -> String
notice shown =
    case shown of
        IncompleteSubmission ->
            "Bu henüz bitmedi: önce her boşluğu doldur ya da bir kitap seç."

        TargetFull ->
            "O boşluk dolu. Önce içinden bir şey çıkar."

        DoesNotFitThere ->
            "O parça bu tür bir boşluğa konmaz."

        NotSolvedYet ->
            "Henüz tam değil. Düzenlemeye devam et."
