# Space ⌨️

## Üldine teave

**"Space"** on top-down 2D pixel-art rogue-like, kus mängija juhib tegelast, kes võitleb vaenlaste lainekondade vastu, kasutades sõnade sisestamise ja sihtimise mehhanisme. Mängija saab liikumiseks kasutada nooleklahve, sihtimiseks hiirt ja tulistamiseks sisestada sõna ja vajutada tühikuklahvi. 

## Mängu mängimine 🎮

Põhitegelane saab liikumiseks kasutada nooleklahve. Selleks, et vaenlasele tulistada, peab mängija sihtima hiirega ja sisestama vastava sõna, seejärel vajutama tühikuklahvi. Sõnadel on erinevad raskusastmed, mis sõltuvad vaenlase tüübist.

Iga vaenlane nõuab erinevat raskusastmega sõna:

- **kuni 5 tähemärki** - lihtne tase (tavalised vaenlased) 🟢
- **5–7 tähemärki** - keskmine tase (kiired vaenlased) 🟡
- **7–10 tähemärki** - raske tase (kilbiga vaenlased ja maagid) 🔴

## Vaenlased 👾

Mängus on mitmeid vaenlaste tüüpe, igaühel oma omadused ja rünnakumehhanismid:

### Tavaline vaenlane
- Ründab põhitegelast, kui jõuab piisavalt lähedale. ⚔️
- Sõna raskusaste: **lihtne** 🟢.

### Kiire vaenlane
- Liigub 1,5 korda kiiremini kui tavalised vaenlased. 🏃‍♂️💨
- Sõna raskusaste: **keskmine** 🟡.

### Kilbiga vaenlane
- Tõrjumiseks tuleb sisestada mitu sõna (sõltuvalt raskusastmest). 🛡️
- Sõna raskusaste: **raske** 🔴.

### Maagi
- Suudab külmutada sõnade sisestamise protsessi, kui tabab põhitegelast maagilise löögiga. ❄️✨
- Sõna raskusaste: **raske** 🔴.

## Mängurežiimid 🕹️

### Lõpmatu režiim ♾️
Mängija peab ellu jääma nii kaua kui võimalik, võideldes laine laine järel vaenlastega. 🌊

Igas lahes on kuni 25 vaenlast (esimeses lahes 10 vaenlast). 💥

Pärast igat lahingut saab mängija külastada poodi, kus saab osta täiustusi:

- **Kilp** - võimaldab põhitegelasel taluda mitu lööki vaenlastelt ilma vigastusteta. 🛡️
- **Lisaelu** - suurendab põhitegelase tervisepunktide kogusummat. ❤️

Mõnikord ilmuvad mänguväljal ka võimendid, nagu:

- **Mittetundlikkus** - muudab põhitegelase ajutiselt haavamatu. ✨
- **Lihtsad sõnad** - sõnad on kergemini sisestatavad. 🟢
- **Kilp** - pakub kaitset vaenlaste rünnakute eest. 🛡️

### Väljakutse režiim 🎯
Mängija peab läbima 10 lainet nii kiiresti kui võimalik ja võitma lõppmängu. ⏱️

Vaenlaste tapmise eest teenitakse punkte, mis aja jooksul kaovad. 💥

Kui mängija teenib rekordilise punktisumma, pääseb ta kõrgeimale 10 mängija edetabelisse. 🏆

## Kasutatavad tehnoloogiad 🛠️
- **Godot** mängumootoris
- **Git** koodiversioonide haldamiseks
