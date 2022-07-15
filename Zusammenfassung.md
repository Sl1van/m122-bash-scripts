# Zusammenfassung

- [Zusammenfassung](#zusammenfassung)
  - [Basics](#basics)
    - [Hello World](#hello-world)
    - [Variable mit Strings verwenden:](#variable-mit-strings-verwenden)
    - [Mehre Linien in die Konsole ausgeben:](#mehre-linien-in-die-konsole-ausgeben)
    - [Input erhalten:](#input-erhalten)
    - [Einen bestimmten Exit-Status generieren](#einen-bestimmten-exit-status-generieren)
  - [Zahlen Rater](#zahlen-rater)
  - [Umgang mit Dateien](#umgang-mit-dateien)
    - [Durch mehrere Argumente iterieren und checken ob diese eine Datei oder ein Ordner sind](#durch-mehrere-argumente-iterieren-und-checken-ob-diese-eine-datei-oder-ein-ordner-sind)
    - [Anzahl Dateien in Ordner zählen:](#anzahl-dateien-in-ordner-zählen)
    - [Alte Dateien löschen](#alte-dateien-löschen)
    - [Zip Cracker:](#zip-cracker)
      - [Master Script](#master-script)
      - [Brute-Force Scripts](#brute-force-scripts)
  - [Text Processing](#text-processing)
  - [Wichtige Befehle](#wichtige-befehle)
    - [Umgestalten einer Tarifliste](#umgestalten-einer-tarifliste)
  - [Weiteres](#weiteres)
    - [PID eines ausgeführten Befehls herausfinden](#pid-eines-ausgeführten-befehls-herausfinden)
  - [Fortgeschrittene Scripts](#fortgeschrittene-scripts)
    - [Dateien anhand der Dateiendung umbenennen](#dateien-anhand-der-dateiendung-umbenennen)
    - [Backup erstellen und via scp auf einen anderen Server transportieren](#backup-erstellen-und-via-scp-auf-einen-anderen-server-transportieren)
    - [Überprüfen ob server online ist](#überprüfen-ob-server-online-ist)
  - [Best Practices](#best-practices)
    - [Runtime Fehler generieren](#runtime-fehler-generieren)
    - [Mit trap checken, ob ein Script einen bestimmten Fehler warf](#mit-trap-checken-ob-ein-script-einen-bestimmten-fehler-warf)
    - [Dedizierte Funktionen für das Logging verwenden](#dedizierte-funktionen-für-das-logging-verwenden)
    - [ShellCheck](#shellcheck)
  - [Security-checkliste](#security-checkliste)
    - [Utilities immer mit ihrem vollständigen Pfad aufrufen](#utilities-immer-mit-ihrem-vollständigen-pfad-aufrufen)
    - [User Inputs nie direkt ausführen](#user-inputs-nie-direkt-ausführen)
    - [Authentifizierung missbrauchen](#authentifizierung-missbrauchen)
    - [Exit Status automatisch checken](#exit-status-automatisch-checken)
    - [Bei nicht gesetzten Variablen das Script beenden](#bei-nicht-gesetzten-variablen-das-script-beenden)
  - [Cheatsheet von Operatoren](#cheatsheet-von-operatoren)

## Basics

### Hello World

Ein Hello World in Bash sieht folgenderweise aus:

```sh
#!/bin/bash
## Hello World
## Author: Silvan Chervet
## Datum: 19.14.2022

echo "Hello world"
```

Der Kommentar auf der ersten Zeile wird benützt um sicherzustellen, dass das Script auch wirklich mit bash läuft.

Echo wird verwendet um einen Output in der Konsole zu kreieren.

### Variable mit Strings verwenden:

```sh
#!/bin/bash
## Variable mit Strings verwenden
## Author: Silvan Chervet
## Datum: 02.06.2022

hostname=`hostname`
echo "Dieses Skript läuft auf $hostname."
```

### Mehre Linien in die Konsole ausgeben:

Mit `\n` kann man Zeilen voneinander trennen und somit mehrere Zeilen mit einem echo ausgeben.

```sh
#!/bin/bash
## Mehre Linien in die Konsole ausgeben
## Author: Silvan Chervet
## Datum: 02.06.2022

printf "Mensch\nBär\nSchwein\nHund\nKatze\nSchaf"
```

### Input erhalten:

Mit folgendem Script kann man einen einen Input abfragen und dann erneut ausgeben:

```sh
#!/bin/bash
## Input erhalten
## Author: Silvan Chervet
## Datum: 09.06.2022

read input
echo "$input"
```

### Einen bestimmten Exit-Status generieren

```sh
#!/bin/bash
## Mehre Linien in die Konsole ausgeben
## Author: Silvan Chervet
## Datum: 09.06.2022

echo “Dieses script wird mit exit status 1 beendet werden.”
exit 1
```

## Zahlen Rater

Dies ist eine Zahlen Rater, welcher eine zufällige Zahl generiert und dann einen Input erwartet. Wenn der Benutzer die richtige Zahl ratet beendet sich das Spiel.

```sh
#!/bin/bash
## Zahlen Rater
## Author: Silvan Chervet
## Datum: 09.06.2022

random_number=$((RANDOM%15+1)) #generate random number

echo "Guess a input between 1 and 15:"
read input

while [ $input -ne $random_number ]
do
  if [ $input -gt $random_number ]
  then
    echo "Your guess is higher than the number input"
  else
    echo "Your guess is lower than the number input"
  fi
  echo "Guess again:"
  read input
done
echo "You guessed the correct input"
```

## Umgang mit Dateien

### Durch mehrere Argumente iterieren und checken ob diese eine Datei oder ein Ordner sind

```sh
#!/bin/bash
## Durch mehrere Argumente iterieren und checken ob diese eine Datei oder ein Ordner sind
## Author: Silvan Chervet
## Datum: 09.06.2022


for var in "$@"
do
    if [[ -d $var ]]||[[ -f $var ]]; then #checks if $var is file or dir
        file $var
    else
        echo "there is no file/dir named $var"
    fi
done
```

### Anzahl Dateien in Ordner zählen:

```sh
#!/bin/bash
## Durch mehrere Argumente iterieren und checken ob diese eine Datei oder ein Ordner sind
## Author: Silvan Chervet
## Datum: 09.06.2022

function countFiles()
 {
   local NUMBER_OF_FILES=$(ls -l | wc -l)
    echo "$NUMBER_OF_FILES"
 }
countFiles
```

### Alte Dateien löschen
```sh
#!/bin/bash
## Alte Dateien löschen
## Author: Silvan Chervet
## Datum: 07.07.2022

path="."
currentTime=$(date +%Y%m%d_%H%M%S)    
log=$path
days=10

find $path -type f -mtime +$days -delete
```

### Zip Cracker:

Dieser Zip Cracker versucht mit einer Brute-Force-Attacke, aus der Zip-Datei "vollsicher.zip", ein 3-5 stelliges Passwort herauszufinden.

Der Zip Cracker besteht aus mehreren Scripts:

- Einem Script, welches die Ausführung und Beendung der anderen Scripts kontrolliert.
- Scripts welche jeweils eine bestimmte Länge von Passwörter brute-forcen.

#### Master Script

```sh
#!/bin/bash
## Zip Cracker
## Author: Silvan Chervet
## Datum: 23.06.2022

./unzipper3003.sh vollsicher.zip &
threepid=$?
./unzipper3004.sh vollsicher.zip &
fourpid=$?
./unzipper3005.sh vollsicher.zip &
fivepid=$?

while(true); do
    echo "test"
    if test -f "./password"; then
        echo "the password of the cracked file is:"
        cat ./password
        rm -f ./password
        kill $threepid
        kill $fourpid
        kill $fivepid
        exit 0;
    fi
    if ! ps -p $threepid > /dev/null
    then
        if ! ps -p $fourpid > /dev/null
        then
            if ! ps -p $fivepid > /dev/null
                then
                if ! test -f "./password"; then
                    echo "the password of the password protected file could not be found out"
                    exit 1;
                fi
            fi
        fi
    fi
    sleep 2
done
```

#### Brute-Force Scripts

```sh
#!/bin/bash
## Zip Cracker
## Author: Silvan Chervet
## Datum: 23.06.2022

for char1 in {a..z} {0..9} ; do
    for char2 in {a..z} {0..9} ; do
        for char3 in {a..z} {0..9} ; do
            unzip -oq -P "$char1$char2$char3" $1
            if [ $? -eq 0 ]; then
                touch ./password
                echo "$char1$char2$char3" > ./password
                exit 0
            fi
        done
    done
done
```

```sh
#!/bin/bash
## Zip Cracker
## Author: Silvan Chervet
## Datum: 23.06.2022

for char1 in {a..z} {0..9} ; do
    for char2 in {a..z} {0..9} ; do
        for char3 in {a..z} {0..9} ; do
            for char4 in {a..z} {0..9} ; do
                unzip -oq -P "$char1$char2$char3$char4" $1
                if [ $? -eq 0 ]; then
                    touch ./password
                    echo "$char1$char2$char3$char4" > ./password
                    exit 0
                fi
            done
        done
    done
done
```

```sh
#!/bin/bash
## Zip Cracker
## Author: Silvan Chervet
## Datum: 23.06.2022

for char1 in {a..z} {0..9} ; do
    for char2 in {a..z} {0..9} ; do
        for char3 in {a..z} {0..9} ; do
            for char4 in {a..z} {0..9} ; do
                for char5 in {a..z} {0..9} ; do
                    unzip -oq -P "$char1$char2$char3$char4$char5" $1
                    if [ $? -eq 0 ]; then
                        touch ./password
                        echo "$char1$char2$char3$char4$char5" > ./password
                        exit 0
                    fi
                done
            done
        done
    done
done
```

## Text Processing

## Wichtige Befehle

| Befehl     | Beschreibung                                                                                       |
| ---------- | -------------------------------------------------------------------------------------------------- |
| `sort`     | Mit sort kann man Daten sortieren. Der Output eines anderen Befehl wird meistens in diesen gepipt. |
| `uniq`     | Dieser filter entfernt doppelte Einträge.                                                          |
| `expand`   | Konvertiert Tabs zu Spaces.                                                                        |
| `unexpand` | Konvertiert Spaces zu Tabs.                                                                        |
| `cut`      | Schneidet Abschnitte aus Felder heraus                                                             |
| `paste`    | Kann zusammen mit cut verwendet werden um mehrere Dateien zusammenzufügen.                         |
| `grep`     | Sehr leistungsfähiges Such-Tool um grosse Mengen von Daten mit Regex zu durchsuchen.               |
| `sed`      | Stream Editor, welcher streams von Daten durchsucht und editiert.                                  |
| `awk`      | Mit awk kann man bei grossen Datensätze Daten auswählen und diese editieren.                       |
| `wc`       | Steht für "word count" und zählt einfach Wörter.                                                   |

### Umgestalten einer Tarifliste

Mit diesem Script werden mehrere an einer Tarifliste vorgenommen damit diese dann schlussendlich korrekt formatiert ist.

```sh
#!/bin/bash
## Tarifliste umgestalten
## Author: Silvan Chervet
## Datum: 24.06.2022

if [ -z $1 ]; then
    echo "input wasn't set exiting...";
    exit 1;
else
    echo "input was set";
fi

if [ -z $2 ]; then
    echo "output wasn't set exiting...";
    exit 1;
else
    echo "output was set";
fi

grep -a -w "^2" $1 | grep -a -v -w "^2\t26" | cut -f3-4 | grep -a -v "[A-Z][0-9][0-9][0-9][0-9][0-9][0-9][0-9]" > $2
```

## Weiteres

### PID eines ausgeführten Befehls herausfinden

Mit `$!` findet man immer heraus was die PID des zuletzt ausgeführten Befehls ist.

```bash
#!/bin/bash
## PID eines ausgeführten Befehls herausfinden
## Author: Silvan Chervet
## Datum: 23.06.2022

myCommand & echo $!
```

## Fortgeschrittene Scripts

### Dateien anhand der Dateiendung umbenennen

```sh
#!/bin/bash
## Dateien anhand der Dateiendung umbenennen
## Author: Silvan Chervet
## Datum: 30.06.2022

function rename_files_custom {
  for file in *; do
    if [ -f $file ]; then
      if [[ $file == *$1 ]]; then
        if [ -z $2 ]; then
          new_name=$(date +%Y-%m-%d)-$file
          mv $file $new_name
        else
          new_name=$2-$file
          mv $file $new_name
        fi
      fi
    fi
  done
}

echo "Please enter a file extension"
read extension
echo "Please enter a custom prefix or leave empty"
read prefix
rename_files_custom $extension $prefix
```

### Backup erstellen und via scp auf einen anderen Server transportieren
```sh
#!/bin/bash
## X
## Author: Silvan Chervet
## Datum: 07.07.2022

zip -r backup.zip $1

today=date+'%m/%d/%Y'
scp remote_username@10.10.0.2:/backups/$today.txt backup.zip
```

### Überprüfen ob server online ist
```sh
#!/bin/bash
## X
## Author: Silvan Chervet
## Datum: 07.07.2022

logging=false

ping $1 -c 1
if [ $? -eq 0 ]; then
    if "$logging" = true; then
        echo "server is online" > log.txt
    fi
    echo "server is online"
else
    if "$logging" = true; then
        echo "server is offline" > log.txt
    fi
    echo "server is offline"
fi
```

## Best Practices

### Runtime Fehler generieren

Um Runtime Fehler frühzeitig zu erkennen können folgende flags mit `set`gesetzt werden, damit sich das Script beendet, sobald ein Fehler auftritt.

```sh
set -o errexit
set -o nounset
set -o pipefail
```

### Mit trap checken, ob ein Script einen bestimmten Fehler warf

Mit `trap` fangen wir hier z.B. einen Fehler ab

```sh
function handle_exit() {
    echo "exiting not cleanly...."
    exit 1
}

trap handle_exit 1
```

### Dedizierte Funktionen für das Logging verwenden

Dedizierte Funktionen für das Logging machen das Logging übersichtlicher und simpler.

```sh
function __msg_error() {
    [[ "${ERROR}" == "1" ]] && echo -e "[ERROR]: $*"
}

function __msg_debug() {
    [[ "${DEBUG}" == "1" ]] && echo -e "[DEBUG]: $*"
}

function __msg_info() {
    [[ "${INFO}" == "1" ]] && echo -e "[INFO]: $*"
}

function read_file() {
  if ls imnotexisting; then
    __msg_error "File not found"
    return ${FILE_NOT_FOUND}
  fi
}
```

### ShellCheck

ShellCheck ist ein cli Tool um sicherzustellen das Bash-Scripts richtig geschrieben sind und hilft bessere Scripts zu schreiben. ShellCheck ist aber auch als Plugin für Vim, vscode und weitere IDEs vorhanden.

## Security-checkliste

### Utilities immer mit ihrem vollständigen Pfad aufrufen

Rufe Utilities immer mit ihrem vollständigen Pfad auf, insbesondere wenn das Script als root ausgeführt wird.

Beispiel einer injection:
Der Benutzer will mit einem Script aufrufen welches ls benützt. In diesem Ordner gibt es dann aber auch ein anderes Script welches auch ls heisst.

```sh
#!/bin/sh

if [ "$USER" = "root" ] ; then
  #malicous code
fi
```

### User Inputs nie direkt ausführen

User Inputs sollen nie direkt ausgeführt werden, sondern immer zu strings umgewandelt werden.

Bei diesem Script ist solch eine Injection möglich.

```sh
#!/bin/sh
echo -n "What file do you seek? "
read name
ls -l $name
```

Beispiel Input für solch eine Injection:

```
. ; /bin/rm -Rf /
```

Das Script kann man ganz einfach sichern, indem man den Input zu einem String umwandelt:

```sh
/bin/ls -l "$name"
```

### Authentifizierung missbrauchen

```sh
if [ $USER = "root" ] ; then
    cd $HOME
fi
```

In diesem Script wird geprüft ob der jetzige user root ist.

Dieses Script kann aber einfach überlistet werden, indem man $USER überschreibt. Darum sollte man immer mit folgendem Befehl den User kontrollieren:

```sh
"$(/usr/bin/id -u -n)"
```

### Exit Status automatisch checken

Für kleine Scripts kann es sehr anstrengend sein jeden einzelnen Exit-Status zu kontrollieren. Mit folgendem Befehl wird das Script sich beenden nach einem nicht 0 Exit-Status.

```sh
set -e
```

Dieses Flag kann man folgenderweise zurücksetzen:

```sh
set +e
```

### Bei nicht gesetzten Variablen das Script beenden

Bash speichert nicht vorhandene Variablen wie Leere. Dies kann zu Problemen führen, wenn man solch ein fehlerhaftes Script ausgeführt. Um sich gegen dieses Problem zu schützen kann man folgenden Befehl ausführen.

```sh
set -u
```

Dieses Flag kann man folgenderweise zurücksetzen:

```sh
set +u
```

## Cheatsheet von Operatoren

| Operator                                   | Beschreibung                                    | Beispiel                        |
|--------------------------------------------|-------------------------------------------------|---------------------------------|
| Integers vergleichen mit []      |                                                 |                                 |
| -gt                                        | Grösser wie                                     | if [ "$a" -gt "$b" ]            |
| -ge                                        | Grösser oder gleich wie                         | if [ "$a" -ge "$b" ]            |
| -lt                                        | Kleiner wie                                     | if [ "$a" -lt "$b" ]            |
| -le                                        | Kleiner oder gleich wie                         | if [ "$a" -le "$b" ]            |
| -eq                                        | Gleich                                          | if [ "$a" -eq "$b" ]            |
| -ne                                        | Ungleich                                        | if [ "$a" -ne "$b" ]            |
| Integers vergleichen mit (()) |                                                 |                                 |
| >                                          | Grösser wie                                     | (("$a" > "$b"))                 |
| >=                                         | Grösser oder gleich wie                         | (("$a" >= "$b"))                |
| <                                          | Kleiner wie                                     | (("$a" < "$b"))                 |
| <=                                         | Kleiner oder gleich wie                         | (("$a" <= "$b"))                |
| String                                     |                                                 |                                 |
| =                                          | Gleich                                          | if [ "$a" = "$b" ]              |
| !=                                         | Ungleich                                        | if [ "$a" != "$b" ]             |
| -z                                         | Leerer String                                   | if [ -z "$String" ]             |
| -n                                         | Not null                                        | if [ -n "$String" ]             |
| File Operatoren                             |                                                 |                                 |
| -e                                         | Überprüft ob die Datei / directory exists       | if [ -e $filename ]             |
| -f                                         | Überprüft ob die Datei eine reguläre Datei ist  | if [ -f $filename ]             |
| -d                                         | Überprüft ob der Ordner existiert               | if [ -d $filename ]             |
| -s                                         | Überprüft ob die Datei leer ist                 | if [ -s $filename ]             |
| -r                                         | Überprüft ob die Datei lesbar ist              | if [ -r $filename ]             |
| -w                                         | Überprüft ob die Datei beschreibbar ist         | if [ -w $filename ]             |
| -x                                         | Überprüft ob die Datei ausführbar ist           | if [ -x $filename ]             |
| Mehrere Operatoren verbinden [[]]                   |                                                 |                                 |
| ||                                         | Oder                                            | if [[ $a == 1 || $b == 1]]      |
| &&                                         | Und                                             | if [[ $a == 1 && $b == 1]]      |
| !                                          | Ungleich                                        |                                 |
| Mehrere Operatoren verbinden []                     |                                                 |                                 |
| -o                                         | Oder                                            | if [ $n1 -gt 24 -o $n2 -lt 66 ] |
| -a                                         | Und                                             | if [ $n1 -gt 24 -a $n2 -lt 66 ] |
