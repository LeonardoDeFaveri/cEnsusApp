import 'package:census/classes/util.dart';
import 'package:equatable/equatable.dart';
import 'package:excel/excel.dart';

class Modello extends Equatable {
  late int id;
  late String nome;
  late List<Domanda> domande;

  Modello(this.id, this.nome, this.domande);

  Modello.fromExcel(Excel excel) {
    final Sheet? sheet = excel.tables["Sheet1"];
    if (sheet == null) {
      throw ExcelException();
    }
    domande = List<Domanda>.empty(growable: true);
    final header = sheet.row(0);
    id = (header.elementAt(1))!.value as int;
    nome = (header.elementAt(2))!.value as String;

    for (int i = 1; i < sheet.maxRows; i++) {
      final risposte = List<Risposta>.empty(growable: true);
      final row = sheet.row(i);
      for (int j = 1; j < row.length && row.elementAt(j) != null; j++) {
        final testoRisposta = (row.elementAt(j))!.value as String;
        risposte.add(Risposta(testoRisposta));
      }
      final testoDomanda = (row.elementAt(0))!.value as String;
      domande.add(Domanda(testoDomanda, risposte));
    }
  }

  @override
  List<Object?> get props => [id, nome, domande];
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
