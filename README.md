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
- **Springen:** tik op de rechterhelft van het scherm, of druk op spatie / ↑
- **Bukken:** houd de linkerhelft ingedrukt, of druk op ↓ (in de lucht val je dan sneller)
- **Pauze:** de knop rechtsboven, of Esc / P

**Gouden snack:** 8 seconden dubbele punten. **Bedorven snack:** 6 seconden zijn springen en bukken omgedraaid.
Met de snacks die je pakt koop je nieuwe karakters.

## Spelen in de browser
Open `index.html`. Om te testen: met `index.html?stad=4` begin je direct in Caïro (de steden zijn genummerd van 0 tot en met 7).

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
- trillingen via de Taptic Engine bij snacks, power-ups, nieuwe steden en botsingen
- je voortgang blijft bewaard
- werkt helemaal offline
- minimale iOS-versie: 17.0, gebouwd met de SDK van je Xcode, dus ook voor de nieuwste iOS
