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

## Basics

### Hello World

Ein Hello World in Bash sieht folgenderweise aus:

```sh
#!/bin/bash

echo "Hello world"
```

Der Kommentar auf der ersten Zeile wird benützt um sicherzustellen, dass das Script auch wirklich mit bash läuft.

Echo wird verwendet um einen Output in der Konsole zu kreieren.

### Variable mit Strings verwenden:

```sh
hostname=`hostname`
echo "Dieses Skript läuft auf $hostname."
```

### Mehre Linien in die Konsole ausgeben:

Mit `\n` kann man Zeilen voneinander trennen und somit mehrere Zeilen mit einem echo ausgeben.

```sh
printf "Mensch\nBär\nSchwein\nHund\nKatze\nSchaf"
```

### Input erhalten:

Mit folgendem Script kann man einen einen Input abfragen und dann erneut ausgeben:

```sh
read input
echo "$input"
```

### Einen bestimmten Exit-Status generieren

```sh
echo “Dieses script wird mit exit status 1 beendet werden.”
exit 1
```

## Zahlen Rater

Dies ist eine Zahlen Rater, welcher eine zufällige Zahl generiert und dann einen Input erwartet. Wenn der Benutzer die richtige Zahl ratet beendet sich das Spiel.

```sh
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

function countFiles()
 {
   local NUMBER_OF_FILES=$(ls -l | wc -l)
    echo "$NUMBER_OF_FILES"
 }
countFiles
```

### Zip Cracker:

Dieser Zip Cracker versucht mit einer Brute-Force-Attacke, aus der Zip-Datei "vollsicher.zip", ein 3-5 stelliges Passwort herauszufinden.

Der Zip Cracker besteht aus mehreren Scripts:

- Einem Script, welches die Ausführung und Beendung der anderen Scripts kontrolliert.
- Scripts welche jeweils eine bestimmte Länge von Passwörter brute-forcen.

#### Master Script

```sh
#!/bin/bash
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
myCommand & echo $!
```

## Fortgeschrittene Scripts

### Dateien anhand der Dateiendung umbenennen

```sh
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

https://tableconvert.com/excel-to-markdown

| Operator                                   | Beschreibung                                    | Beispiel                        |
|--------------------------------------------|-------------------------------------------------|---------------------------------|
| Compare integers - single brackets []      |                                                 |                                 |
| -gt                                        | Grösser wie                                     | if [ "$a" -gt "$b" ]            |
| -ge                                        | Grösser oder gleich wie                         | if [ "$a" -ge "$b" ]            |
| -lt                                        | Kleiner wie                                     | if [ "$a" -lt "$b" ]            |
| -le                                        | Kleiner oder gleich wie                         | if [ "$a" -le "$b" ]            |
| -eq                                        | Gleich                                          | if [ "$a" -eq "$b" ]            |
| -ne                                        | Ungleich                                        | if [ "$a" -ne "$b" ]            |
| Compare integers - double parentheses (()) |                                                 |                                 |
| >                                          | Grösser wie                                     | (("$a" > "$b"))                 |
| >=                                         | Grösser oder gleich wie                         | (("$a" >= "$b"))                |
| <                                          | Kleiner wie                                     | (("$a" < "$b"))                 |
| <=                                         | Kleiner oder gleich wie                         | (("$a" <= "$b"))                |
| String                                     |                                                 |                                 |
| =                                          | Gleich                                          | if [ "$a" = "$b" ]              |
| !=                                         | Ungleich                                        | if [ "$a" != "$b" ]             |
| -z                                         | Leerer String                                   | if [ -z "$String" ]             |
| -n                                         | Not null                                        | if [ -n "$String" ]             |
| File Operators                             |                                                 |                                 |
| -e                                         | Überprüft ob die Datei / directory exists       | if [ -e $filename ]             |
| -f                                         | Überprüft ob die Datei eine reguläre Datei ist  | if [ -f $filename ]             |
| -d                                         | Überprüft ob der Ordner existiert               | if [ -d $filename ]             |
| -s                                         | Überprüft ob die Datei leer ist                 | if [ -s $filename ]             |
| -r                                         | Überprüft ob die Datei leesbar ist              | if [ -r $filename ]             |
| -w                                         | Überprüft ob die Datei beschreibbar ist         | if [ -w $filename ]             |
| -x                                         | Überprüft ob die Datei ausführbar ist           | if [ -x $filename ]             |
| Compound comparison [[]]                   |                                                 |                                 |
| ||                                         | Oder                                            | if [[ $a == 1 || $b == 1]]      |
| &&                                         | Und                                             | if [[ $a == 1 && $b == 1]]      |
| !                                          | Ungleich                                        |                                 |
| Compound comparison []                     |                                                 |                                 |
| -o                                         | Oder                                            | if [ $n1 -gt 24 -o $n2 -lt 66 ] |
| -a                                         | Und                                             | if [ $n1 -gt 24 -a $n2 -lt 66 ] |


<table>
    <tr>
        <td>Operator</td>
        <td>Beschreibung</td>
        <td>Beispiel</td>
    </tr>
    <tr>
        <td>Compare integers - single brackets []</td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td>-gt</td>
        <td>Grösser wie</td>
        <td>if [ "$a" -gt "$b" ]</td>
    </tr>
    <tr>
        <td>-ge</td>
        <td>Grösser oder gleich wie</td>
        <td>if [ "$a" -ge "$b" ]</td>
    </tr>
    <tr>
        <td>-lt</td>
        <td>Kleiner wie</td>
        <td>if [ "$a" -lt "$b" ]</td>
    </tr>
    <tr>
        <td>-le</td>
        <td>Kleiner oder gleich wie</td>
        <td>if [ "$a" -le "$b" ]</td>
    </tr>
    <tr>
        <td>-eq</td>
        <td>Gleich</td>
        <td>if [ "$a" -eq "$b" ]</td>
    </tr>
    <tr>
        <td>-ne</td>
        <td>Ungleich</td>
        <td>if [ "$a" -ne "$b" ]</td>
    </tr>
    <tr>
        <td>Compare integers - double parentheses (())</td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td>&gt;</td>
        <td>Grösser wie</td>
        <td>(("$a" &gt; "$b"))</td>
    </tr>
    <tr>
        <td>&gt;=</td>
        <td>Grösser oder gleich wie</td>
        <td>(("$a" &gt;= "$b"))</td>
    </tr>
    <tr>
        <td>&lt;</td>
        <td>Kleiner wie</td>
        <td>(("$a" &lt; "$b"))</td>
    </tr>
    <tr>
        <td>&lt;=</td>
        <td>Kleiner oder gleich wie</td>
        <td>(("$a" &lt;= "$b"))</td>
    </tr>
    <tr>
        <td>String</td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td>=</td>
        <td>Gleich</td>
        <td>if [ "$a" = "$b" ]</td>
    </tr>
    <tr>
        <td>!=</td>
        <td>Ungleich</td>
        <td>if [ "$a" != "$b" ]</td>
    </tr>
    <tr>
        <td>-z</td>
        <td>Leerer String</td>
        <td>if [ -z "$String" ]</td>
    </tr>
    <tr>
        <td>-n</td>
        <td>Not null </td>
        <td>if [ -n "$String" ]</td>
    </tr>
    <tr>
        <td>File Operators</td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td>-e</td>
        <td>Überprüft ob die Datei / directory exists </td>
        <td>if [ -e $filename ]</td>
    </tr>
    <tr>
        <td>-f</td>
        <td>Überprüft ob die Datei eine reguläre Datei ist </td>
        <td>if [ -f $filename ]</td>
    </tr>
    <tr>
        <td>-d</td>
        <td>Überprüft ob der Ordner existiert </td>
        <td>if [ -d $filename ]</td>
    </tr>
    <tr>
        <td>-s</td>
        <td>Überprüft ob die Datei leer ist</td>
        <td>if [ -s $filename ]</td>
    </tr>
    <tr>
        <td>-r</td>
        <td>Überprüft ob die Datei leesbar ist</td>
        <td>if [ -r $filename ]</td>
    </tr>
    <tr>
        <td>-w</td>
        <td>Überprüft ob die Datei beschreibbar ist</td>
        <td>if [ -w $filename ]</td>
    </tr>
    <tr>
        <td>-x</td>
        <td>Überprüft ob die Datei ausführbar ist</td>
        <td>if [ -x $filename ]</td>
    </tr>
    <tr>
        <td>Compound comparison [[]]</td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td>||</td>
        <td>Oder</td>
        <td>if [[ $a == 1 || $b == 1]]</td>
    </tr>
    <tr>
        <td>&amp;&amp;</td>
        <td>Und</td>
        <td>if [[ $a == 1 &amp;&amp; $b == 1]]</td>
    </tr>
    <tr>
        <td>!</td>
        <td>Ungleich</td>
        <td></td>
    </tr>
    <tr>
        <td>Compound comparison []</td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td>-o</td>
        <td>Oder</td>
        <td>if [ $n1 -gt 24 -o $n2 -lt 66 ]</td>
    </tr>
    <tr>
        <td>-a</td>
        <td>Und</td>
        <td>if [ $n1 -gt 24 -a $n2 -lt 66 ]</td>
    </tr>
</table>