module Content.Room exposing (label)

{-| Short verb phrases for the walking room (contract v1.3): the proximity
prompt ("E: Read the closure notice") and each hotspot's accessible name.

Every hotspot has its own phrase, clue spots included. `label` takes no World,
so it can't reuse clue titles that change with history; these phrases read
the same under every history. None of them hints at an answer.

-}

import Content.Mystery as Mystery
import Domain exposing (BookTab(..), ClueId(..), Hotspot(..), HubProp(..))


label : Hotspot -> String
label hotspot =
    case hotspot of
        ClueSpot clue ->
            clueLabel clue

        BoxSpot ->
            "Tezgâhın altındaki kutuyu aç"

        DiarySpot ->
            "Parlayan günlüğü aç"

        CratesSpot ->
            "Kurtarılan kitapları ayır"

        BoardSpot ->
            "Tamir haftasını planla"

        ShelfSpot ->
            "Açılış rafını sırala"

        StageSpot ->
            "Gölge sahnesini kur"

        BookTableSpot ->
            "Dört kitabı karşılaştır"

        BrokenGlassSpot ->
            "Kırık camları topla"


clueLabel : ClueId -> String
clueLabel clue =
    case clue of
        ClosureNotice ->
            "Kapanış ilanını oku"

        FamilyPhotograph ->
            "Aile fotoğrafına bak"

        HubProp RoofAndShelves ->
            "Çatıya ve raflara bak"

        HubProp CommunityWall ->
            "Mahalle duvarına bak"

        HubProp OrderDesk ->
            "Sipariş masasına bak"

        WalterDiaryPage ->
            "Walter’ın günlük sayfasını oku"

        GlassDeliverySlip ->
            "Cam teslim fişini oku"

        RubbleAndShelvesNote ->
            "Walter’ın tamir notlarını oku"

        BudgetAllocation ->
            "Tahtalara ve paraya bak"

        ShelfPlaque ->
            "Raf levhasını oku"

        ShadowScript ->
            "Gölge oyunu metnini oku"

        StageSketch ->
            "Sahne taslağına bak"

        CutoutBox ->
            "Figür kutusunun içine bak"

        RuthsEmail ->
            "Ruth’un e-postasını oku"

        RememberedSentence ->
            "Lucy’nin hatırladığı satırı oku"

        InscriptionClue ->
            "El yazısı notla ilgili ipucuna bak"

        CandidatePage candidate tab ->
            tabVerb tab ++ (Mystery.candidate candidate).label


tabVerb : BookTab -> String
tabVerb tab =
    case tab of
        CoverTab ->
            "Resme bak: "

        TextTab ->
            "Metni oku: "

        DedicationTab ->
            "El yazısı notu oku: "
