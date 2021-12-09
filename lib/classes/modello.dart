import 'package:equatable/equatable.dart';
import 'package:excel/excel.dart';

class Modello {
  late int id;
  late String nome;
  late List<Domanda> domande;

  Modello(this.id, this.nome, this.domande);

  Modello.fromExcel(Excel excel) {
    for (var row in excel.tables[0]!.rows) {
      List<Risposta> risposte = List<Risposta>.empty();
      int i = 1;
      while (row[i] != null) {
        risposte.add(Risposta(row[i] as String));
        i++;
      }
      domande.add(Domanda(row[0] as String, risposte));
    }
    // Estrarre anche il nome
    Modello(id, "", domande);
  }
}

class Domanda extends Equatable {
  final String testo;
  final List<Risposta> risposte;

  const Domanda(this.testo, this.risposte);

  @override
  List<Object?> get props => [testo];
}

class Risposta extends Equatable {
  final String testo;

  const Risposta(this.testo);

  @override
  List<Object?> get props => [testo];
}
