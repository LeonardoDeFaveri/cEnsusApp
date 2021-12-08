import 'dart:math';

import 'package:census/classes/modello.dart';
import 'package:census/classes/utente.dart';

class Sondaggio {
  late int id;
  Utente somministratore;
  late Modello modello;
  late bool _completato;
  late bool _informativaPrivacyAccettata;
  late List<RispostaSelezionata> risposteSelezionate;

  Sondaggio(this.id, this.somministratore, this.modello, this._completato,
      this._informativaPrivacyAccettata, this.risposteSelezionate);

  Sondaggio.newSurvey(this.somministratore, this.modello) {
    id = Random().nextInt(15000);
    _completato = false;
    _informativaPrivacyAccettata = false;
    for (var domanda in modello.domande) {
      risposteSelezionate.add(RispostaSelezionata(domanda, null));
    }
  }

  Sondaggio.fromExcel(this.somministratore, String path) {
    modello = Modello.fromExcel(path);
  }

  void setCompletato() {
    _completato = true;
  }

  bool isCompletato() => _completato;

  void accettaInformativa() {
    _informativaPrivacyAccettata = true;
  }

  bool isInformativaAccettata() => _informativaPrivacyAccettata;

  bool seleziona(Domanda domanda, Risposta risposta) {
    int index = modello.domande.indexOf(domanda);
    if (index == -1) {
      return false;
    }
    if (!modello.domande[index].risposte.contains(risposta)) {
      return false;
    }
    risposteSelezionate[index].seleziona(risposta);
    return true;
  }
}

class RispostaSelezionata {
  Domanda domanda;
  Risposta? risposta;

  RispostaSelezionata(this.domanda, this.risposta);

  void seleziona(Risposta risposta) {
    this.risposta = risposta;
  }

  void deseleziona() {
    risposta = null;
  }
}
