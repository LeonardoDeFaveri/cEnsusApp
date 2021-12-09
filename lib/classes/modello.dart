import 'package:equatable/equatable.dart';
import 'package:excel/excel.dart';

class Modello {
  late int id;
  late String nome;
  late List<Domanda> domande;

  Modello(this.id, this.nome, this.domande);

  Modello.fromExcel(Excel excel) {
    int id = excel.tables[0]!.rows[0][1] as int;
    String nome = excel.tables[0]!.rows[0][2] as String;
    int col = 1, row = 1;
    while (row < excel.tables[0]!.maxRows) {
      List<Risposta> risposte = List<Risposta>.empty();
      while (excel.tables[0]!.rows[row][col] != null) {
        risposte.add(Risposta(excel.tables[0]!.rows[row][col] as String));
        col++;
      }
      domande.add(Domanda(excel.tables[0]!.rows[row][0] as String, risposte));
      row++;
    }
    Modello(id, nome, domande);
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
