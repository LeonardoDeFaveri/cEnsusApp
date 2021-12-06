class Modello {
  late List<Domanda> domande;

  Modello(this.domande);

  Modello.fromExcel(String path) {
    domande = List<Domanda>.empty();
  }
}

class Domanda {
  String testo;
  List<Risposta> risposte;

  Domanda(this.testo, this.risposte);
}

class Risposta {
  String testo;

  Risposta(this.testo);
}
