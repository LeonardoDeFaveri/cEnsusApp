# cEnsus

Il codice che si trova in questa repository implementa un applicazione mobile per la gestione di sondaggi comunali.
Nello specifico sono state implementate le seguenti funzionalità:
- compliazione di un sondaggio
- salvataggio di un sondaggio come bozza
- compilazione di una bozza, ovvero la ripresa della compilazione di un sondaggio sospeso

Per testare l'applicazione è possibile intsallarla in un dispositivo mobile, il simulatore del framework,  
opprure il simulatore via browser Google Chrome (Il browser predefinito per il testing è Chrome, se si desidera utilizzarne altri è necessario configurare il framework).

Il framework utilizzato è Flutter; l'applicazione è scritta in linguaggio dart.

Per eseguire l'applicaizione dal simulatore via Browser è necessario aprire il terminale nella cartella cEnsusApp/ ed eseguire il comando 'flutter run'; una volta eseguito il comando (attendere anche qualche secondo) si aprirà Chrome che permetterà di usare l'app.

Per eseguire il codice di testing, usare il comando 'flutter test'.

Se si desidera visualizzare la documentazione tramite dartdoc, è necessatio installare gli appositi componenti.
Digitare quindi i seguenti comandi, dalla cartella:
- dart pub get dartdoc
- dart pub global activate dartdoc
- export PATH="$PATH":"$HOME/.pub-cache/bin"
- dart pub global activate dhttpd
I predecenti comandi sono per la configurazione, il seguente è il comando per attivare il server http:
- dhttpd --path doc/api

Digitare il comando 'dartdoc' per generare la documentazione.
Per visualizzare la documentazione, una volta attivato il server, andare all'indirizzo 'localhost:8080' dal proprio browser.

È possibile tuttavia accedere al file della documentazione, senza necessariamente attivare il server; il file si trova al percorso cEnsusApp/doc/api/index.html
Se si accede al file, senza usare il server, non è possible sfruttare la barra di ricerca della pagina.
