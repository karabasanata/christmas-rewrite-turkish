module Content.Mystery exposing (candidate)

{-| The four 1998 candidate books. Every tab describes the book plainly, and
no candidate is written up as more special than the others.

Which clues each one matches (brief section 6):

    A illustrated edition: picture yes, sentence yes, inscription yes
    B school edition:      picture yes, sentence yes, “For Peter, love Dad”
    C River Stories:       picture yes, different passage, inscription yes
    D plain edition:       snowy wood, sentence yes, inscription yes

The illustration wording matches public/assets: A, B and C share
illustration-fox-bridge.svg, D uses illustration-fox-wood.svg.

-}

import Domain exposing (CandidateContent, CandidateId(..))


candidate : CandidateId -> CandidateContent
candidate candidateId =
    case candidateId of
        CandidateA ->
            { label = "Tilki ile Fener, resimli baskı"
            , cover = "Bez kapak, yaldızlı başlığı aşınıp incelmiş. İçinde tam sayfa bir resim var: taş bir köprünün altında fener taşıyan bir tilki."
            , text = "“…ve tilki yağan karın içinde yürümeye devam etti. Fener, son yolcu eve dönene kadar yanık kaldı.”"
            , dedication = "Ön kapağın içinde mavi mürekkeple elle yazılmış: “Lucy’ye, sevgilerle, Annen.”"
            }

        CandidateB ->
            { label = "Tilki ile Fener, okul baskısı"
            , cover = "Kütüphane damgalı sert karton kapak. İçinde tam sayfa bir resim var: taş bir köprünün altında fener taşıyan bir tilki."
            , text = "“…ve tilki yağan karın içinde yürümeye devam etti. Fener, son yolcu eve dönene kadar yanık kaldı.” Altında: Sınıf için sorular."
            , dedication = "Ön kapağın içinde mavi mürekkeple elle yazılmış: “Peter’a, sevgilerle, Baban.”"
            }

        CandidateC ->
            { label = "Nehir Hikâyeleri, seçki"
            , cover = "Sırtı solmuş kalın bir derleme. Hikâyelerden birinde tam sayfa bir resim var: taş bir köprünün altında fener taşıyan bir tilki."
            , text = "“…o gece nehir taşkındı, bu yüzden tilki suyun kenarına oturup sabahı bekledi.”"
            , dedication = "Ön kapağın içinde mavi mürekkeple elle yazılmış: “Lucy’ye, sevgilerle, Annen.”"
            }

        CandidateD ->
            { label = "Tilki ile Fener, sade baskı"
            , cover = "Kâğıt kapak, köşeleri kullanılmaktan yumuşamış. İçinde tam sayfa bir resim var: karlı bir ormanda fener taşıyan bir tilki."
            , text = "“…ve tilki yağan karın içinde yürümeye devam etti. Fener, son yolcu eve dönene kadar yanık kaldı.”"
            , dedication = "Ön kapağın içinde mavi mürekkeple elle yazılmış: “Lucy’ye, sevgilerle, Annen.”"
            }
