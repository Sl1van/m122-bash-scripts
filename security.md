# Security-checkliste

## Utilities immer mit ihrem vollständigen Pfad aufrufen
Rufe Utilities immer mit ihrem vollständigen Pfad auf, insbesondere wenn das Script als root ausgeführt wird.

Beispiel einer injection:
Der Benutzer will mit einem Script aufrufen welches ls benützt. In diesem ordner gibt es dann aber auch ein anderes Script welches auch ls heisst.

```sh
#!/bin/sh

if [ "$USER" = "root" ] ; then
  #malicous code
fi
```

## User Inputs nie direkt ausführen
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
## Authentifizierung missbrauchen
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
## Exit Status automatisch checken
Für kleine Scripts kann es sehr anstrngend sein jeden einzelnen Exit-Status zu kontrollieren. Mit folgendem Befehl wird das Script sich beenden nach einem nicht 0 Exit-Status.
```sh
set -e
```
Dieses Flag kann man folgenderweise zurücksetzen:
```sh
set +e
```

## Bei nicht gesetzten Variablen das Script beenden
Bash speichert nicht vorhandene Variablen wie Leere. Dies kann zu Problemen führen, wenn man solch ein fehlerhaftes Script asuführt. Um sich gegen dieses Problem zu schützen kann man folgenden Befehl ausführen.

```sh
set -u
```
Dieses Flag kann man folgenderweise zurücksetzen:
```sh
set +u
```