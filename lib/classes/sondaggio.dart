import 'package:census/classes/modello.dart';
import 'package:census/classes/utente.dart';

class Sondaggio {
  Utente somministratore;
  late Modello modello;
  late bool completato;
  late bool informativaPrivacyAccettata;
  late List<RispostaSelezionata> risposteSelezionate;

  Sondaggio(this.somministratore, this.modello, this.completato,
      this.informativaPrivacyAccettata, this.risposteSelezionate);

  Sondaggio.newSurvey(this.somministratore, this.modello) {
    completato = false;
    informativaPrivacyAccettata = false;
    for (var domanda in modello.domande) {
      risposteSelezionate.add(RispostaSelezionata(domanda, null));
    }
  }

  Sondaggio.fromExcel(this.somministratore, String path) {
    modello = Modello.fromExcel(path);
  }

  void setCompletato() {
    completato = true;
  }

  bool isCompletato() => completato;

  void accettaInformativa() {
    informativaPrivacyAccettata = true;
  }

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
