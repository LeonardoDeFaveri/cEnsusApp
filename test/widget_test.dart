// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:census/classes/gestore_memoria_locale.dart';
import 'package:census/classes/modello.dart';
import 'package:census/classes/sondaggio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Test delle funzioni per il recupero dei dati dalla memoria',
    (WidgetTester tester) async {
      final service = GestoreMemoriaLocale();

      final domande = List<Domanda>.empty(growable: true);
      final modello = Modello(1, "Servizi del municipio", domande);
      //final expected = Sondaggio(modello, false, true, risposteSelezionate,
      //    "Descrizione del sondaggio");
    },
  );
}
