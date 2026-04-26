# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with the Velatum series writing project.

## DONT:

Never user directory work/. Its just a temporary working directory.

## Project Overview

**Velatum Series, Band 3** — Dark paranormal romance completing the trilogy. This is a writing project, not a code project.

- **Ziel:** Band 3 fertigstellen und veröffentlichen (Self-Publishing)
- **Genre:** Dark Romance, paranormal, BDSM-Elemente, Okkultes Worldbuilding
- **Zielgruppe:** Erwachsene (17+), Dark Romance Fans
- **Sprache:** Deutsch
- **Status:** Band 1 & 2 fertig, Band 3 in Planung/Schreiben

---

## Schreib-Richtlinien (Binding)

**VOR DEM SCHREIBEN: Skill aktivieren**

Alle Schreibregeln, Story-Grid-Methodik, Stil und Richtlinien sind im Skill `/velatum-coauthor` hinterlegt. Dieser wird auf Abruf geladen und ist bindend für alle Szenen.

---

## Material-Struktur

```
Velatum 3 - Claude/
├── .claude/skills/velatum-coauthor/ ← SCHREIB-RICHTLINIEN (Skill, auf Abruf)
├── 01-material/               ← INPUT: Zusammenfassungen & Charaktere
│   ├── VELATUM-Buch1.txt
│   ├── VELATUM-Buch2.txt
│   ├── charaktere.md
│   └── zusammenfassung-band-1-2.md
├── 02-planning/               ← PLANUNG & STRUKTUR
│   ├── storyboard.md          (Szene-für-Szene Übersicht)
│   ├── charakterbogen.md      (Entwicklung pro Charakter)
│   ├── plot-beats.md          (Handlungs-Meilensteine)
│   └── timeline.md            (Chronologie Band 1-3)
├── 03-drafts/                 ← ROHFASSUNGEN
│   ├── teil3_draft-v1.md
│   └── ...
├── 04-notes/                  ← ARBEITSNOTIZEN
│   ├── szenen-ideen.md
│   └── dialoge.md
├── 05-output/                 ← FERTIGE VERSIONEN
│   ├── teil3_final.md
│   └── teil3_lektoriert.md
└── CLAUDE.md                  ← Diese Datei
```

---

## Zentrale Schreib-Anforderungen

### Tone & Voice

- Sarkastisch, witzig, auch in dunklen Momenten
- Moderne deutsche Umgangssprache (kein Pathos)
- Schimpfwörter sind okay (Teil von Emmas Stimme)
- Explizite sexuelle Szenen (BDSM, ritualistisch, nicht pornografisch)

### Perspektive

- **Hauptperspektive:** 1. Person (Emma Winter)
- **Sekundär:** 3. Person Limited (Alexander, Leo, mystische Sequenzen)
- **Velatum-Interludes:** 3. Person, bibel-ähnliche Verse (rituell, erhaben)

### Pacing

- Schnelle Schnitte zwischen Aktion, Dialog, Interieur
- Kurze Absätze (meist 1-3 Sätze)
- Szenenwechsel abrupt (Zeilenumbruch, kein "Drei Tage später" wenn nicht nötig)
- Mischung: 60% Charakter/Intimität, 30% Spannung/Mystery, 10% Action

### Wichtige Elemente (NICHT ignorieren)

- **Synästhesie:** Emmas übernatürliche Wahrnehmung durchgehend verwenden
- **Das Arcanum:** Logik konsistent, Regeln zählen, Rituale haben Gewicht
- **Alexander's Dualität:** Dunkel UND verliebt, nicht schöngefärbt
- **Sex als Sprache:** Intimität zeigt Macht, Vertrauen, Liebe — nicht nur erotik
- **Weltaufbau-Konsistenz:** London, Wien, Ägypten, andere Tempel — alles zusammenhängend

---

## Zentrale Plotfäden für Band 3

**Hauptfrage:** Was kostet die Hieros Gamos und kann echte Liebe das Ritual überleben?

### Zu beantworten:

1. **Das Ritual selbst** — Erfolg? Misserfolg? Welche Konsequenzen?
2. **Emmas wahre Bestimmung** — Warum sie? (Verbindung zur Mutter?)
3. **Alexanders Wahl** — Kann er sich gegen Großvater stellen?
4. **Grandfathers Geheimnis** — Was ist sein echter Plan?
5. **Leo's Warnung** — Was versucht er zu sagen?
6. **Die Liebe vs. Das System** — Gibt es einen Ausweg?

### Offene Fragen aus Band 1 & 2:

- Was passiert bei Misslingen der Hieros Gamos?
- Warum ist Emma "auserwählt"?
- Was trägt Alexander für Schuld mit sich?
- Kann das Arcanum verändert werden oder nur zerstört?

---

## Workflow

### Phase 1: Planning (02-planning/)

- Szene-für-Szene Gliederung (storyboard.md)
- Charakterentwicklung pro Person
- Plot-Beats definieren

### Phase 2: Drafting (03-drafts/)

- Rohtext schreiben (schnell, nicht perfekt)
- In der Richtlinie bleiben (Skill `/velatum-coauthor`)
- Arbeitsnotizen sammeln (04-notes/)

### Phase 3: Revision

- Text gegen Richtlinien abgleichen
- Spannung/Pacing überprüfen
- Konsistenz checken (Charaktere, Weltaufbau, Kontinuität)

### Phase 4: Final (05-output/)

- Saubere, lesbare Version
- Lektorat-Pass
- Export-Version

---

## Technische Details

- **Sprache:** Deutsch
- **Zeitform:** Präteritum (Vergangenheit)
- **Gedanken:** Normaltext, nicht kursiv
- **Kapitel:** Numerisch (Kapitel 1, Kapitel 2, etc.) mit Optional-Beschreibung
- **Velatum-Verse:** Format "Kapitel VII, Verse 11-13" — archäisch, rituell
- **Dateiformat:** .md (Markdown) für einfache Bearbeitung/Versionierung
- **Altersfreigabe:** Ab 17 Jahre (wie Band 1 & 2)

---

## Wichtige Referenzen

- **Charaktere verstehen:** `/01-material/charaktere.md` lesen
- **Plot-Kontinuität:** `/01-material/zusammenfassung-band-1-2.md` vor Szenen lesen
- **Schreibstil & Regeln:** Skill `/velatum-coauthor` aktivieren

---

## Red Flags (Was nicht tun)

❌ Emma sentimentalisch/kitschig schreiben (sie würde kotzen)
❌ Arcanum-Logik vergessen oder trivialisieren
❌ Alexander schöngefärbt darstellen (er ist dunkel UND verliebt)
❌ Sex-Szenen ohne emotionalen Kontext (sind Ritual & Sprache)
❌ Lange Info-Dumps über Arcanum-Struktur (tropfenweise offenbaren)
❌ Plot-Twists aus dem Nichts (müssen logisch folgen)
❌ Gewalt als Softcore-Erotik (nicht vermischen)

---

## Erfolgs-Kriterien für Band 3

✅ Mindestens 80.000-100.000 Wörter (wie Band 1 & 2)
✅ Alle offenen Plotfäden adressiert
✅ Finale emotionale Auflösung (Emma & Alexander, Arcanum, mystische Fragen)
✅ Konsistenz mit Band 1 & 2 (Ton, Charaktere, Weltaufbau)
✅ Leser sollten nicht wissen, ob sie lachen oder weinen sollen (dunkle Romantik!)
✅ Reihe kann hier enden (aber Tür offen für Spin-offs?)

---

## Notes for Future Sessions

- **Tina's E-Mail:** tina@tinahagmann-books.com (für Finales & Veröffentlichung)
- **Ziel:** Serie beenden & Geld verdienen → Self-Publishing oder Verlag?
- **Timeline:** (user-defined, add here if known)
- **Memory System:** Nutze Skill `/velatum-coauthor` + `/01-material/` als Quelle der Wahrheit, nicht nur im Head

---

**Letzte Aktualisierung:** 2026-04-25
**Status:** Band 3 Planning Phase
**Nächster Schritt:** Szene-für-Szene Gliederung + Plot-Skizze definieren
