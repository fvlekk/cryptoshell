# CryptoShell

Projet éducatif de cybersécurité simulant les mécanismes d'un ransomware — chiffrement, détection et récupération — dans un environnement de laboratoire isolé.

> **Avertissement éthique** : Ce projet est strictement à des fins pédagogiques. Ne jamais exécuter ces scripts sur des systèmes réels ou sans autorisation explicite. L'auteur décline toute responsabilité en cas d'usage malveillant.

---

## Aperçu

CryptoShell est structuré en 6 phases progressives couvrant le cycle complet d'une attaque par ransomware :

| Phase | Sujet | Contenu |
|-------|-------|---------|
| 1 | Reconnaissance | Scanner les fichiers cibles dans un répertoire |
| 2 | Chiffrement basique | Chiffrement/déchiffrement XOR fichier par fichier |
| 3 | Ransomware | Chiffrement massif + génération de note de rançon |
| 4 | Bombes logiques | Étude théorique et simulation |
| 5 | Polymorphisme | Étude théorique des techniques d'évasion |
| 6 | Détection & récupération | Scanner d'infection et outil de restauration |

---

## Prérequis

- Linux / Bash
- Outils standard : `find`, `xxd`, `uuidgen`, `tr`, `fold`
- Aucune installation externe requise

---

## Utilisation

### Rendre tous les scripts exécutables

```bash
chmod +x */*.sh
```

### Phase 1 — Reconnaissance

```bash
cd phase1
./setup_lab.sh        # Crée l'environnement de test
./recon.sh ./data     # Scanne les fichiers .txt et .dat
cat target.list       # Liste des cibles trouvées
```

### Phase 2 — Chiffrement basique (XOR)

```bash
cd phase2
./setup_lab.sh

./encrypt.sh file.txt        # → file.txt.locked  (clé dans .cryptoshell_key)
./decrypt.sh file.txt.locked # → restaure file.txt
```

### Phase 3 — Ransomware

```bash
cd phase3
./setup_lab.sh

./cryptoshell.sh lab                   # Lance l'attaque sur ./lab
find ./data -name "*.locked"           # Vérifie les fichiers chiffrés
cat ./data/RANSOM_NOTE.txt             # Lit la note de rançon
```

### Phase 4 — Bombes logiques (théorie)

```bash
cd phase4
./cryptoshell.sh lab
cat 4c.txt    # Questions et analyse
```

### Phase 5 — Polymorphisme (théorie)

```bash
cd phase5
./cryptoshell.sh lab
cat 5c.txt    # Questions et analyse
```

### Phase 6 — Détection & récupération

```bash
cd phase6
./setup_lab.sh

./cryptoshell.sh lab   # Simule une attaque
./scanner.sh .         # Détecte les fichiers infectés
./recovery.sh .        # Déchiffre tout et supprime les traces
```

---

## Structure du projet

```
Cryptoshell/
├── phase1/          # Reconnaissance
│   ├── setup_lab.sh
│   └── recon.sh
├── phase2/          # Chiffrement XOR
│   ├── setup_lab.sh
│   ├── encrypt.sh
│   ├── decrypt.sh
│   └── xor_helper.sh
├── phase3/          # Ransomware complet
│   ├── setup_lab.sh
│   ├── cryptoshell.sh
│   └── fct.sh
├── phase4/          # Bombes logiques
├── phase5/          # Polymorphisme
├── phase6/          # Détection & récupération
│   ├── setup_lab.sh
│   ├── cryptoshell.sh
│   ├── scanner.sh
│   └── recovery.sh
└── rapport.pdf      # Rapport du projet
```

---

## Déploiement & utilisation

CryptoShell est un projet de scripts Bash — aucun serveur ni build requis.

### Utilisation locale (Linux / macOS / WSL)

```bash
# 1. Cloner le repo
git clone https://github.com/fvlekk/cryptoshell.git
cd cryptoshell

# 2. Rendre tous les scripts exécutables
chmod +x */*.sh

# 3. Lancer une phase (exemple phase 3)
cd phase3
./setup_lab.sh      # Crée l'environnement de test isolé
./cryptoshell.sh lab
```

> Chaque phase crée son propre répertoire `data/` ou `lab/` temporaire. Rien n'est modifié en dehors du dossier de la phase.

### Prérequis système

Les outils suivants doivent être disponibles (présents par défaut sur Linux) :

```bash
which xxd uuidgen find tr fold   # vérifier la disponibilité
```

Sur Ubuntu/Debian si manquants :
```bash
sudo apt install xxd uuid-runtime
```

### Environnement recommandé

| Environnement | Compatible |
|---------------|------------|
| Linux natif | Oui |
| macOS | Oui |
| WSL2 (Windows) | Oui |
| Git Bash (Windows) | Partiel (`xxd` peut manquer) |
| Docker | Oui — `docker run -it --rm ubuntu bash` |

---

## Licence

Ce projet est distribué sous licence [MIT](LICENSE) — usage éducatif uniquement.
