import 'package:census/classes/modello.dart';
import 'package:excel/excel.dart';

class Sondaggio {
  late Modello modello;
  late bool _completato;
  late bool _informativaPrivacyAccettata;
  late List<RispostaSelezionata> risposteSelezionate;
  late DateTime dataOra;

  Sondaggio(this.modello, this._completato, this._informativaPrivacyAccettata,
      this.risposteSelezionate);

  Sondaggio.newSurvey(this.modello) {
    _completato = false;
    _informativaPrivacyAccettata = false;
    for (var domanda in modello.domande) {
      risposteSelezionate.add(RispostaSelezionata(domanda, null));
    }
  }

  Sondaggio.fromExcel(Excel excel) {
    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        Domanda domanda = Domanda(row[0] as String, List<Risposta>.empty());
        Risposta risposta = Risposta(row[1] as String);
        seleziona(domanda, risposta);
      }
    }
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

  void setDataOra(DateTime dataOra) {
    this.dataOra = dataOra;
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
