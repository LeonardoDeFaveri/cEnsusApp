import 'package:census/classes/modello.dart';
import 'package:census/classes/util.dart';
import 'package:excel/excel.dart';

class Sondaggio {
  late Modello modello;
  late bool _completato;
  late bool _informativaPrivacyAccettata;
  late List<RispostaSelezionata> risposteSelezionate;
  late DateTime dataOra;
  late String descrizione;

  Sondaggio(this.modello, this._completato, this._informativaPrivacyAccettata,
      this.risposteSelezionate, this.descrizione);

  Sondaggio.newSurvey(this.modello) {
    _completato = false;
    _informativaPrivacyAccettata = false;
    risposteSelezionate = List<RispostaSelezionata>.empty(growable: true);
    for (var domanda in modello.domande) {
      risposteSelezionate.add(RispostaSelezionata(domanda, null));
    }
    descrizione = "";
  }

  Sondaggio.fromExcel(Excel excel) {
    final Sheet? sheet = excel.tables["Sheet1"];
    if (sheet == null) {
      throw ExcelException();
    }
    risposteSelezionate = List<RispostaSelezionata>.empty(growable: true);
    // Intestazione del modello
    final domande = List<Domanda>.empty(growable: true);
    final header = sheet.row(0);
    final idModello = (header.elementAt(1))!.value as int;
    final nomeModello = (header.elementAt(2))!.value as String;

    // Intestazione del sondaggio
    descrizione = (header.elementAt(3))!.value as String;
    dataOra = DateTime.fromMillisecondsSinceEpoch(
        (header.elementAt(4))!.value as int);
    _informativaPrivacyAccettata = (header.elementAt(5))!.value as bool;
    _completato = (header.elementAt(6))!.value as bool;

    // Carica tutte le domande e le risposte del modello
    for (int i = 1; i < sheet.maxRows; i++) {
      final risposte = List<Risposta>.empty(growable: true);
      final row = sheet.row(i);
      for (int j = 2; j < row.length && row.elementAt(j) != null; j++) {
        final testoRisposta = (row.elementAt(j))!.value as String;
        risposte.add(Risposta(testoRisposta));
      }
      final testoDomanda = (row.elementAt(0))!.value as String;
      domande.add(Domanda(testoDomanda, risposte));
    }
    modello = Modello(idModello, nomeModello, domande);

    // Carica le risposte selezionate
    for (int i = 1; i < sheet.maxRows; i++) {
      final row = sheet.row(i);
      final testoRispostaSelezionata = (row.elementAt(1))?.value;
      if (testoRispostaSelezionata == null) {
        risposteSelezionate.add(RispostaSelezionata(domande[i - 1], null));
      } else {
        Risposta risposta = Risposta(testoRispostaSelezionata);
        risposteSelezionate.add(RispostaSelezionata(domande[i - 1], risposta));
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
