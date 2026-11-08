# Snack Trip!

▶ **Speel online:** https://thomdewit05-design.github.io/r-f4g4tte/

Een endless runner waarmee je de wereld rond rent. In elke stad pak je de lokale snacks.

Het spel werkt in de browser (telefoon en computer), als web-app op het beginscherm van een iPhone/iPad, en als native iOS-app. Je kunt kiezen tussen Nederlands en Engels.

## Steden
| Stad | Snack | Obstakels |
|---|---|---|
| 🇳🇱 Amsterdam | stroopwafel | paaltjes, fietsen, tulpenkratten, meeuwen, bord "BUKKEN" |
| 🇫🇷 Parijs | croissant | bistrotafeltjes, paaltjes, duiven, bord "ATTENTION" |
| 🇬🇧 Londen | kopje thee | telefooncellen, brievenbussen, bord "MIND YOUR HEAD" |
| 🇮🇹 Rome | gelato | gebroken zuilen, Vespa's, bord "ATTENZIONE" |
| 🇪🇬 Caïro | falafel | kruiken, kamelen, valken, Egyptische lantaarns |
| 🇯🇵 Tokio | sushi | pionnen, gelukskatten, rode lampionnen, kraaien |
| 🇧🇷 Rio | kokosnoot | voetballen, zandkastelen, surfplanken, papegaaien, bord "CUIDADO" |
| 🇺🇸 New York | pizzapunt | brandkranen, vuilnisbakken, bord "LOW CLEARANCE" |

Elke 500 m kom je in een nieuwe stad. Na New York begin je weer in Amsterdam, maar dan sneller.

## Besturing
- **Tikken (standaard):** tik rechts om te springen, houd links ingedrukt om te bukken
- **Vegen:** veeg omhoog (of tik) om te springen, veeg omlaag om te bukken (instelbaar)
- **Toetsenbord:** spatie / ↑ om te springen, ↓ om te bukken, Esc / P voor pauze

Bij je eerste potje krijg je een korte oefenronde. Na een pauze telt het spel af (3-2-1) voordat je weer verder rent.

## In het spel
- **Muziek per stad**, live gegenereerd: een wals in Parijs, de hijaz-toonladder in Caïro, samba in Rio, jazz in New York…
- **Power-ups:** 🟡 gouden snack (x2), 🧲 magneet, 🛡️ schild, ✈️ vliegtuig naar de volgende stad, en 🟢 bedorven snack (besturing omgedraaid)
- **Snackregen** vlak voor elke nieuwe stad
- **Karakters met een eigen vaardigheid:** Kikker springt hoger, Koe start met een schild, Haring heeft langere power-ups, Klompje start met een magneet, Panda verdient +25% snacks
- **Opdrachten:** steeds 3 tegelijk, die moeilijker worden naarmate je er meer haalt
- **Dagelijks:** een beloning (hoger als je meerdere dagen achter elkaar speelt) en een uitdaging per dag
- **Ranglijst:** je top 10, en in de iOS-app ook Game Center
- **Score delen:** als afbeelding, via het deelmenu
- **Instellingen:** muziek, geluid, trillen, besturing, taal en de uitleg opnieuw spelen

## Spelen in de browser
Open `index.html`. Om te testen: met `index.html?stad=4` begin je direct in Caïro (de steden zijn genummerd van 0 tot en met 7). Met `?debug` kunnen testscripts de spelstatus uitlezen.

## Op iPhone/iPad als web-app
1. Open https://thomdewit05-design.github.io/r-f4g4tte/ in Safari
2. Kies **Deel → Zet op beginscherm**.

Het spel opent dan fullscreen met een eigen icoon, werkt ook offline (via `sw.js`) en houdt rekening met de notch en het Dynamic Island.

## Als native iOS-app (Xcode)
In de map `ios/` staat een SwiftUI-project dat het spel in een `WKWebView` laat zien. Het gebruikt direct de `index.html` uit de hoofdmap, dus aanpassingen aan het spel komen vanzelf in de app terecht.

1. Open `ios/SnackTrip.xcodeproj` in de nieuwste Xcode op een Mac.
2. Kies bij *Signing & Capabilities* je eigen team en pas zo nodig de bundle-ID `nl.snacktrip.game` aan.
3. Kies je iPhone of een simulator en druk op ▶.

Wat de app doet:
- fullscreen in landschap op de iPhone (alle standen op de iPad), zonder statusbalk
- **Game Center**-ranglijst (ID `snacktrip.highscore`)
- **iCloud**: je voortgang op al je apparaten
- **Deelmenu** van iOS om je score als afbeelding te delen
- **Trillingen** via de Taptic Engine
- werkt helemaal offline, met een privacy manifest (`PrivacyInfo.xcprivacy`)
- minimale iOS-versie 17.0, gebouwd met de SDK van je Xcode

> **Gratis Apple-account?** Daarmee werken Game Center en iCloud niet. Haal dan in Xcode bij *Signing & Capabilities* die twee onderdelen weg (of maak `CODE_SIGN_ENTITLEMENTS` leeg). De rest van de app werkt gewoon.

## App Store
Alles voor de App Store staat in [`appstore/`](appstore/README.md): teksten in het Nederlands en Engels, screenshots, privacylabels, de Game Center-instellingen en de stappen om de app in te dienen. Het privacybeleid staat in `privacy.html`.
