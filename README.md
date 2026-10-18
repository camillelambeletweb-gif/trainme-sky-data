# trainme-sky-data

Spiegel der Satelliten-Bahndaten für die App TrainMe Sky.

Warum: CelesTrak gibt dieselben Daten pro IP-Adresse nur einmal pro Aktualisierung (rund 2 Stunden)
heraus. Mobilfunkanbieter und Hotspots teilen eine IP-Adresse unter vielen Kunden – ohne Spiegel
würden viele Nutzer abgewiesen. Dieser Spiegel holt die Daten alle 2 Stunden **einmal** und stellt sie
über GitHub Pages bereit. Die App lädt von hier und nur im Notfall direkt von CelesTrak.

Dateien: `stations.txt`, `visual.txt`, `starlink.txt`, `updated.txt` (Zeitpunkt der letzten Aktualisierung).

Daten: CelesTrak (celestrak.org).

## Einrichten (einmalig, ca. 5 Minuten)

1. Auf github.com ein neues **öffentliches** Repository `trainme-sky-data` anlegen.
2. Den Inhalt dieses Ordners hochladen (inklusive des versteckten Ordners `.github`).
3. Im Repository: **Settings → Pages → Build and deployment → Source: GitHub Actions**.
4. **Actions → Bahndaten aktualisieren → Run workflow** einmal von Hand starten.
5. Nach rund einer Minute prüfen: `https://DEIN-NAME.github.io/trainme-sky-data/stations.txt`
6. In der App in `lib/services/tle_service.dart` eintragen:
   `static const mirrorBase = 'https://DEIN-NAME.github.io/trainme-sky-data';`

Danach läuft alles von selbst.
