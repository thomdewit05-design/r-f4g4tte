# App Store-pakket voor Snack Trip!

Alles wat je in **App Store Connect** moet invullen. Je hebt een betaald [Apple Developer-account](https://developer.apple.com/programs/) nodig (€99 per jaar).

## 1. App aanmaken
| Veld | Waarde |
|---|---|
| Naam | Snack Trip! |
| Bundle-ID | `nl.snacktrip.game` (of je eigen; pas hem dan ook aan in Xcode) |
| SKU | snacktrip-001 |
| Primaire taal | Nederlands (voeg Engels toe als tweede taal) |
| Categorie | Games → Arcade (tweede: Casual) |
| Leeftijd | 4+ (geen geweld, geen aankopen, geen chat; reclame staat op "alle leeftijden") |
| Prijs | Gratis |
| Privacybeleid-URL | https://thomdewit05-design.github.io/r-f4g4tte/privacy.html |
| Support-URL | https://github.com/thomdewit05-design/r-f4g4tte |

**Privacylabels ("App Privacy"):** door AdMob verzamelt de app wel gegevens. Vul in wat Google opgeeft voor de Google Mobile Ads SDK ([uitleg van Google](https://developers.google.com/admob/ios/privacy/data-disclosure)). Meestal is dat:
- **Gebruikt om je te volgen (tracking):** Apparaat-ID (advertentie-ID)
- **Gekoppeld aan jou / derde partij reclame:** Apparaat-ID, Productinteractie, Advertentiegegevens, Globale locatie
- **Analyse/diagnose:** Crashgegevens, Prestatiegegevens, Andere diagnostische gegevens

Game Center en iCloud zijn diensten van Apple zelf.

## 2. Game Center
1. App Store Connect → je app → **Services → Game Center → Ranglijsten → +**
2. Kies *Klassiek*, ID **`snacktrip.highscore`** (precies zo, dit staat in `ios/SnackTrip/NativeBridge.swift`).
3. Score: geheel getal, *hoogste is het best*. Naam: "Meeste snacks" / "Most snacks".

## 3. Teksten

### Nederlands
**Subtitel (max. 30):** Ren de wereld rond!

**Promotietekst (max. 170):** Nieuw: Rome, Caïro en Rio! Pak in elke stad de lokale snacks, ontwijk Vespa's en kamelen, en vlieg met het vliegtuigje naar de volgende stad.

**Beschrijving:**
```
Snack Trip! is een vrolijke endless runner waarmee je de wereld rond rent. In elke stad pak je de lokale snacks!

🌍 8 STEDEN
Amsterdam, Parijs, Londen, Rome, Caïro, Tokio, Rio en New York. Elke stad heeft een eigen skyline, eigen muziek, eigen snacks en eigen obstakels: van Amsterdammertjes en telefooncellen tot kamelen en surfplanken.

🧇 PAK DE SNACKS
Stroopwafels, croissants, gelato, sushi, pizza… Vlak voor elke nieuwe stad valt er een snackregen!

⚡ POWER-UPS
• Gouden snack: dubbele punten
• Magneet: trekt alle snacks naar je toe
• Schild: overleeft één botsing
• Vliegtuig: vlieg over alles heen naar de volgende stad
• Pas op voor bedorven snacks: dan zijn springen en bukken omgedraaid!

🏃 8 FIGUREN
Speel als Sam, hardloopster Lisa, bouwvakker Henk, kok Marco, uitvinder Amira, zakenman Kenji, supersnelle Oma Gerda of voetballer Diego. Iedereen heeft een eigen vaardigheid!

🚲 MENSEN OP STRAAT
Ontwijk fietsers in Amsterdam, mimespelers in Parijs, de koninklijke wacht in Londen, gladiatoren in Rome en skaters in New York.

🏆 OPDRACHTEN EN UITDAGINGEN
Voltooi opdrachten, haal elke dag een beloning en een nieuwe uitdaging, en strijd mee op de Game Center-ranglijst.

✨ EN VERDER
• Eenvoudige besturing: tikken of vegen
• Werkt helemaal offline
• Voortgang via iCloud op al je apparaten
• Gratis, geen aankopen
```

**Trefwoorden (max. 100):** `runner,rennen,springen,stroopwafel,wereldreis,steden,snacks,arcade,fietser,offline,reizen,spel`

### English
**Subtitle:** Run around the world!

**Promotional text:** New: Rome, Cairo and Rio! Grab the local snacks in every city, dodge scooters and camels, and fly to the next city by plane.

**Description:**
```
Snack Trip! is a cheerful endless runner that takes you around the world. Grab the local snacks in every city!

🌍 8 CITIES
Amsterdam, Paris, London, Rome, Cairo, Tokyo, Rio and New York, each with its own skyline, music, snacks and obstacles.

🧇 GRAB THE SNACKS
Stroopwafels, croissants, gelato, sushi, pizza… and a snack rain right before every new city!

⚡ POWER-UPS
• Golden snack: double points
• Magnet: pulls all snacks towards you
• Shield: survive one crash
• Plane: fly over everything to the next city
• Watch out for rotten snacks: they swap jump and duck!

🏃 8 CHARACTERS: Sam, runner Lisa, builder Henk, chef Marco, inventor Amira, businessman Kenji, speedy Grandma Gerda and footballer Diego, each with a unique ability.

🚲 STREET LIFE: dodge cyclists, mimes, royal guards, gladiators and skaters.

🏆 MISSIONS, daily rewards, daily challenges and Game Center leaderboards.

✨ Simple tap or swipe controls · plays offline · iCloud sync · free, no purchases
```

**Keywords:** `runner,endless,jump,world,travel,cities,snacks,arcade,skater,offline,casual,trip`

## Reclame (AdMob en AdSense)
Het spel toont reclame **na het doodgaan**:
- **"Verder spelen?"**: kijk een beloonde reclame en ren verder waar je was (1x per potje).
- **Tussendoor-reclame**: na elke 2e keer doodgaan, maximaal 1x per minuut. Dit stel je in met `ADS` bovenaan de reclamecode in `index.html`.

Nu staan er nog **testadvertenties** in. Zo zet je echte reclame aan:

**iOS-app (AdMob)**
1. Maak een account op [admob.google.com](https://admob.google.com) en voeg de app toe (iOS, "Snack Trip!").
2. Maak twee advertentieblokken aan: *Interstitial* en *Rewarded*.
3. Vul je ID's in:
   - `ios/SnackTrip/Info.plist` → `GADApplicationIdentifier` (je **app-ID**, `ca-app-pub-…~…`)
   - `ios/SnackTrip/Ads.swift` → `interstitialUnitID` en `rewardedUnitID` (je **blok-ID's**, `ca-app-pub-…/…`)
4. Zet in AdMob onder *Privacy en berichten* een **AVG-toestemmingsbericht** aan (verplicht in de EU) en een **IDFA-uitleg**.
5. Plaats een `app-ads.txt` op je website (AdMob geeft je de regel). Voor GitHub Pages: maak een bestand `app-ads.txt` in de hoofdmap van de repo.

**Website (AdSense / H5 Games Ads)**
1. Vraag op [adsense.google.com](https://adsense.google.com) toegang aan en voeg de site toe. Voor games heb je ook de *H5 Games Ads*-beta nodig.
2. Vul in `index.html` bij `ADS.webClient` je uitgevers-ID in (`ca-pub-…`).
3. Test eerst met `webTest: true`. Werkt het, zet dan `webTest: false`.
4. Zolang er geen ID is (of geen reclame beschikbaar), toont de website eigen promo's van Snack Trip!.

## 4. Screenshots
In `screenshots/` staan kant-en-klare screenshots in de formaten die Apple vraagt:
- `*-iphone-6.9-*.png`: 2868 × 1320 (iPhone 6,9")
- `*-ipad-13-*.png`: 2752 × 2064 (iPad 13")

`nl-` is voor de Nederlandse pagina en `en-` voor de Engelse. Upload per taal de 6 screenshots van elk apparaat.

## 5. Uploaden
1. Open `ios/SnackTrip.xcodeproj` in Xcode en kies bij *Signing & Capabilities* je team.
2. Kies als doel **Any iOS Device**, dan **Product → Archive** en daarna **Distribute App → App Store Connect**.
3. Test eerst via **TestFlight** op je eigen iPhone.
4. Vul de bovenstaande gegevens in en dien de app in ter beoordeling.

## Over richtlijn 4.2 (minimale functionaliteit)
Apple wijst apps af die alleen een website tonen. Snack Trip! werkt volledig offline en gebruikt Game Center, iCloud-synchronisatie, trillingen en het deelmenu van iOS. Daarmee is het een volwaardige app. Krijg je toch een afwijzing, verwijs dan in je antwoord naar deze native functies.
