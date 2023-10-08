# Sonarqube-Docker-Compose
> Sonarqube-Docker-Compose ist eine Docker-Compose Datei für die Installation von Sonarqube und Postgresql

Dieses Repository enthält eine Docker-Compose-Datei, um das Static Application Security Testing Tool (SAST) Sonarqube Community LTS und einen Datenbank-Server Postgresql über Docker-Container realisieren zu können, um anschließend mittels Static Code Analysis Code auf Bugs, Code Smells, Schwachstellen und Technical Debts prüfen zu können.

Das Repository dient als persönliches Backup für den Einsatz in einem privaten LAN.

Die Lauffähigkeit der Docker-Container wurde auf einem Ubuntu 23.04 ("Lunar Lobster") getestet.

## Download des Repositorys und Starten der Docker-Container

```shell
# Vorarbeiten auf dem Host-System zur Sicherstellung der Lauffähigkeit der Docker-Container
# Siehe Docker Host Requirements: https://hub.docker.com/_/sonarqube
# Als root User:
sudo sysctl -w vm.max_map_count=262144 # Maximale Anzahl des Memory Mappings eines Prozesses
sudo sysctl -w fs.file-max=131072 # Maximale Anzahl offener Dateien
# Als User, mit dessen Rechten Docker startet:
ulimit -n 131072 # Maximale Anzahl offener Datei-Deskriptoren in der Shell
ulimit -u 8192 # Maximale Anzahl von Nutzerprozessen in der Shell
```

Siehe auch sysctl_settings.sh und ulimit_settings.sh.

```shell
# Klonen des Repositorys und Wechsel in das Verzeichnis
git clone https://github.com/steffen-roesemann/sonarqube-docker-compose.git
cd sonarqube-docker-compose

# Starten der Docker-Container für Sonarqube und Postgresql als Dienst
docker-compose up -d

# Pull des Docker Images vom SonarqubeScanner (CLI zum Scannen von Code-Repos)
docker pull sonarsource/sonar-scanner-cli:latest
```

Über einen Webbrowser kann die Weboberfläche des Docker-Containers von Sonarqube dann wie folgt aufgerufen werden:

- http://localhost:9000 oder http://{ip-adresse-des-hosts}:9000


## Scannen eines lokalen Code-Repositories mit der Docker-Instanz von Sonarqube-Scanner

Um ein lokales Code-Repository mit einer Docker-Instanz des Sonarqube-Scanners nach Bugs, Code Smells,  Schwachstellen und Technical Debts zu scannen, kann auf der Kommandozeile folgender Befehl verwendet werden:

```shell
docker run --rm --network=host -e SONAR_HOST_URL='http://127.0.0.1:9000' -e SONAR_SCANNER_OPTS="-Dsonar.projectKey={PROJECT_KEY}" -e SONAR_LOGIN="{AUTH_STRING}" -v "$PWD:/usr/src" sonarsource/sonar-scanner-cli
```

Hinweis: Den PROJECT_KEY und den AUTH_STRING erhält man, wenn man sich über die Weboberfläche von Sonarqube einloggt (siehe oben) und dort ein Projekt anlegt.

## Hinweise zum Arbeiten mit den Docker-Containern

```shell
# Stoppen der laufenden Container-Dienste
docker-compose down

# Updaten der verwendeten Images
docker-compose pull

# Neustarten der Container als Dienst
docker-compose up -d

# Laufende Docker-Container anzeigen lassen
docker ps

# Alle Docker-Container, Images und Netzwerke löschen (ACHTUNG! Löscht auch alles andere!)
docker system prune -a

# Docker Volumes anzeigen und löschen
docker volume ls
docker volume rm {Name_des_Volumes}
```

## Nutzungsbedingungen

Die folgenden Bedingungen regeln die Nutzung dieser Software. Durch die Verwendung erklären 
ihr euch mit den nachstehenden Bedingungen einverstanden:

Die Software wird "wie sie ist" zur Verfügung gestellt, ohne jegliche ausdrückliche oder stillschweigende Gewährleistung. Dies schließt, aber ist nicht beschränkt auf, Gewährleistungen hinsichtlich der Eignung für einen bestimmten Zweck, der Marktgängigkeit und der Nichtverletzung von Rechten Dritter ein.

Ich übernehme keine Verantwortung oder Haftung für die Richtigkeit, Vollständigkeit, Zuverlässigkeit oder Aktualität der Software oder der damit erzielten Ergebnisse.

In keinem Fall hafte ich für direkte, indirekte, zufällige, besondere oder Folgeschäden, die sich aus der Nutzung oder Unmöglichkeit der Nutzung der Software ergeben, einschließlich, aber nicht beschränkt auf entgangenen Gewinn, Datenverlust, Geschäftsunterbrechung oder jegliche andere kommerzielle Schäden oder Verluste.

Ihr stimmt zu, die Software nur in Übereinstimmung mit den geltenden Gesetzen und Vorschriften zu nutzen. Ich übernehme keine Verantwortung für rechtliche Konsequenzen, die sich aus einer rechtswidrigen Nutzung der Software ergeben.

Ihr erkennt an, dass die Software möglicherweise Fehler, Unvollkommenheiten oder technische Probleme aufweisen kann. Ich übernehme keine Verantwortung für etwaige Schäden oder Datenverluste, die durch solche Probleme verursacht werden.

Jegliche Kommunikation, die über die Software erfolgt, liegt in eurer Verantwortung. Ich hafte nicht für den Inhalt solcher Kommunikation oder die Verwendung, die ihr davon macht.

Durch die Verwendung dieser Software erklärt ihr euch damit einverstanden, auf jegliche Ansprüche, Klagen oder Forderungen gegenüber mir zu verzichten, die sich aus der Nutzung der Software ergeben könnte.