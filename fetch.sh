#!/usr/bin/env bash
# Holt die Satellitengruppen einmal von CelesTrak und legt sie in site/ ab.
# Klappt eine Gruppe nicht, wird die zuletzt veröffentlichte Version behalten.
set -uo pipefail
mkdir -p site
UA="TrainMeSky-mirror/1.0 (+https://github.com/${GITHUB_REPOSITORY:-})"

for g in stations visual starlink; do
  ok=0
  if curl -sfL -A "$UA" --max-time 90 -o "site/$g.txt" \
      "https://celestrak.org/NORAD/elements/gp.php?GROUP=$g&FORMAT=tle"; then
    grep -q '^1 ' "site/$g.txt" && ok=1
  fi
  if [ "$ok" = 1 ]; then
    echo "$g: $(grep -c '^1 ' "site/$g.txt") Satelliten"
  else
    echo "$g: CelesTrak hat nicht geliefert – letzte Version wird behalten"
    if ! { curl -sfL --max-time 90 -o "site/$g.txt" "${PAGES:-}/$g.txt" && grep -q '^1 ' "site/$g.txt"; }; then
      rm -f "site/$g.txt"
      echo "$g: auch keine alte Version vorhanden"
    fi
  fi
done

date -u +%Y-%m-%dT%H:%M:%SZ > site/updated.txt
touch site/.nojekyll
cat > site/index.html <<'HTML'
<!doctype html><meta charset="utf-8"><title>TrainMe Sky data</title>
<p>Satellite orbit data (TLE) for the TrainMe Sky app, mirrored every 2 hours from
<a href="https://celestrak.org">CelesTrak</a>.</p>
HTML
