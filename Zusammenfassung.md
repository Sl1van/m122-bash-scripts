# Zusammenfassung

- [Zusammenfassung](#zusammenfassung)
  - [Basics](#basics)
    - [Hello World](#hello-world)
    - [Variable mit Strings verwendem:](#variable-mit-strings-verwendem)
    - [Mehre Linien in die Konsole ausgeben:](#mehre-linien-in-die-konsole-ausgeben)
    - [Variable mit Strings verwendem:](#variable-mit-strings-verwendem-1)
    - [Input erhalten:](#input-erhalten)
  - [Zahlen Rater](#zahlen-rater)
  - [Umgang mit Dateien](#umgang-mit-dateien)
    - [Durch mehrere Argumente iterieren und checken ob diese eine Datei oder ein Ordner sind](#durch-mehrere-argumente-iterieren-und-checken-ob-diese-eine-datei-oder-ein-ordner-sind)
    - [Zip Cracker:](#zip-cracker)
    - [Text Processing](#text-processing)
  - [PID eines ausgeführten Befehls herausfinden](#pid-eines-ausgeführten-befehls-herausfinden)
  - [Weitere Tipps](#weitere-tipps)
    - [ShellCheck](#shellcheck)
    - [Security-checkliste](#security-checkliste)
      - [Utilities immer mit ihrem vollständigen Pfad aufrufen](#utilities-immer-mit-ihrem-vollständigen-pfad-aufrufen)
      - [User Inputs nie direkt ausführen](#user-inputs-nie-direkt-ausführen)
      - [Authentifizierung missbrauchen](#authentifizierung-missbrauchen)
      - [Exit Status automatisch checken](#exit-status-automatisch-checken)
      - [Bei nicht gesetzten Variablen das Script beenden](#bei-nicht-gesetzten-variablen-das-script-beenden)

## Basics

### Hello World
TODO


### Variable mit Strings verwendem:

```sh
hostname=`hostname`
echo "Dieses Skript läuft auf $hostname."
```

### Mehre Linien in die Konsole ausgeben:
Mit `\n` kann man Zeilen vonseinander trennen und somit mehrere Zeilen mit einem echo ausgeben.
```sh
printf "Mensch\nBär\nSchwein\nHund\nKatze\nSchaf"
```

### Variable mit Strings verwendem:

```sh
echo "Enter file/directory name:"
read file1
```

### Input erhalten:
Mit folgendem Script kann man einen einen Input abfragen und dann erneut ausgeben: 
```sh
read input
echo "$input"
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

###  Durch mehrere Argumente iterieren und checken ob diese eine Datei oder ein Ordner sind
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

### Zip Cracker:
TODO

### Text Processing
TODO




## PID eines ausgeführten Befehls herausfinden
Mit `$!` findet man immmer heraus was die PID des zu letzt audgeführten Befehls ist.
```bash
myCommand & echo $!
```

## Weitere Tipps

### ShellCheck
ShellCheck ist ein cli Tool um sicherzustellen das Bash-Scripts richtig geschrieben sind und hilft bessere Scripts zu schreiben. ShellCheck ist aber auch als Plugin für Vim, vscode und weitere IDEs vorhanden. 

### Security-checkliste

#### Utilities immer mit ihrem vollständigen Pfad aufrufen
Rufe Utilities immer mit ihrem vollständigen Pfad auf, insbesondere wenn das Script als root ausgeführt wird.

Beispiel einer injection:
Der Benutzer will mit einem Script aufrufen welches ls benützt. In diesem ordner gibt es dann aber auch ein anderes Script welches auch ls heisst.

```sh
#!/bin/sh

if [ "$USER" = "root" ] ; then
  #malicous code
fi
```

#### User Inputs nie direkt ausführen
User Inputs sollen nie direkt ausgeführt werden, sondern immer zu strings umewandelt werden.
 
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
#### Authentifizierung missbrauchen
```sh
if [ $USER = "root" ] ; then
    cd $HOME
fi
```
In diesem Script wird geprüft ob der jetztige user root ist.

Dieses Script kann aber einfach überlistet werden, indem man $USER überschreibt. Darum sollte man immer mit folgendem Befehl den User kontrollieren:
```sh
"$(/usr/bin/id -u -n)"
```
#### Exit Status automatisch checken
Für kleine Scripts kann es sehr anstrngend sein jeden einzelnen Exit-Status zu kontrollieren. Mit folgendem Befehl wird das Script sich beenden nach einem nicht 0 Exit-Status.
```sh
set -e
```
Dieses Flag kann man folgenderweise zurücksetzen:
```sh
set +e
```

#### Bei nicht gesetzten Variablen das Script beenden
Bash speichert nicht vorhandene Variablen wie Leere. Dies kann zu Problemen führen, wenn man solch ein fehlerhaftes Script asuführt. Um sich gegen dieses Problem zu schützen kann man folgenden Befehl ausführen.

```sh
set -u
```
Dieses Flag kann man folgenderweise zurücksetzen:
```sh
set +u
```


| Operator | Description                                                                                                    | Example                  |
| -------- | -------------------------------------------------------------------------------------------------------------- | ------------------------ |
| =        | Checks if the value of two operands are equal or not; if yes, then the condition becomes true.                 | [ $a = $b ] is not true. |
| !=       | Checks if the value of two operands are equal or not; if values are not equal then the condition becomes true. | [ $a != $b ] is true.    |
| -z       | Checks if the given string operand size is zero; if it is zero length, then it returns true.                   | [ -z $a ] is not true.   |
| -n       | Checks if the given string operand size is non-zero; if it is nonzero length, then it returns true.            | [ -n $a ] is not false.  |
| str      | Checks if str is not the empty string; if it is empty, then it returns false.                                  | [ $a ] is not false.     |
