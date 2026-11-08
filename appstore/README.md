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
| Leeftijd | 4+ (geen geweld, geen aankopen, geen chat) |
| Prijs | Gratis |
| Privacybeleid-URL | https://thomdewit05-design.github.io/r-f4g4tte/privacy.html |
| Support-URL | https://github.com/thomdewit05-design/r-f4g4tte |

**Privacylabels ("App Privacy"):** kies *Geen gegevens verzameld*. De app heeft geen tracking, advertenties of analysediensten. Game Center en iCloud zijn diensten van Apple zelf.

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
Amsterdam, Parijs, Londen, Rome, Caïro, Tokio, Rio en New York. Elke stad heeft een eigen skyline, eigen muziek, eigen snacks en eigen obstakels: van fietsen en telefooncellen tot kamelen en surfplanken.

🧇 PAK DE SNACKS
Stroopwafels, croissants, gelato, sushi, pizza… Vlak voor elke nieuwe stad valt er een snackregen!

⚡ POWER-UPS
• Gouden snack: dubbele punten
• Magneet: trekt alle snacks naar je toe
• Schild: overleeft één botsing
• Vliegtuig: vlieg over alles heen naar de volgende stad
• Pas op voor bedorven snacks: dan zijn springen en bukken omgedraaid!

🐸 6 KARAKTERS
Elk met een eigen vaardigheid: de kikker springt hoger, de koe start met een schild, de panda verdient meer snacks…

🏆 OPDRACHTEN EN UITDAGINGEN
Voltooi opdrachten, haal elke dag een beloning en een nieuwe uitdaging, en strijd mee op de Game Center-ranglijst.

✨ EN VERDER
• Eenvoudige besturing: tikken of vegen
• Werkt helemaal offline
• Voortgang via iCloud op al je apparaten
• Geen advertenties, geen aankopen, geen tracking
```

**Trefwoorden (max. 100):** `runner,rennen,springen,stroopwafel,wereldreis,steden,snacks,arcade,eend,offline,reizen,spel`

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

🐸 6 CHARACTERS, each with a unique ability.

🏆 MISSIONS, daily rewards, daily challenges and Game Center leaderboards.

✨ Simple tap or swipe controls · fully offline · iCloud sync · no ads, no purchases, no tracking
```

**Keywords:** `runner,endless,jump,world,travel,cities,snacks,arcade,duck,offline,casual,trip`

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
