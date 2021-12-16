// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:census/classes/gestore_memoria_locale.dart';
import 'package:census/classes/modello.dart';
import 'package:census/classes/sondaggio.dart';
import 'package:census/classes/utente.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Test delle funzioni per il recupero dei dati dalla memoria',
    (WidgetTester tester) async {
      final service = GestoreMemoriaLocale();

      // Domande e relative risposte
      final domande = List<Domanda>.empty(growable: true);
      final risposte = List<Risposta>.empty(growable: true);
      risposte.add(const Risposta("Pessimo"));
      risposte.add(const Risposta("Negativo"));
      risposte.add(const Risposta("Così così"));
      risposte.add(const Risposta("Buono"));
      risposte.add(const Risposta("Eccezione"));
      domande.add(Domanda("Come valuti il servizio di accoglienza", risposte));
      domande.add(Domanda("Come valuti l’ufficio tecnico", risposte));
      domande.add(Domanda("Come valuti l’ufficio anagrafe", risposte));
      domande.add(Domanda("Come valuti l’ufficio tributi", risposte));

      final modello = Modello(1, "Servizi del municipio", domande);

      // Risposte selezionate
      final risposteSelezionate =
          List<RispostaSelezionata>.empty(growable: true);
      risposteSelezionate.add(
          RispostaSelezionata(domande.elementAt(0), const Risposta("Buono")));
      risposteSelezionate.add(
          RispostaSelezionata(domande.elementAt(1), const Risposta("Pessimo")));
      risposteSelezionate.add(RispostaSelezionata(domande.elementAt(2), null));
      risposteSelezionate.add(RispostaSelezionata(domande.elementAt(3), null));
      final expected = Sondaggio(
        modello,
        false,
        true,
        risposteSelezionate,
        "descrizione sondaggio",
        DateTime.fromMillisecondsSinceEpoch(1639139959317),
      );

      final bozze = await service.prelevaBozze();
      expect(bozze.elementAt(0), expected);

      final modelli = await service.prelevaModelli();
      expect(modelli.elementAt(0), expected.modello);

      final sondaggi = await service.prelevaSondaggi();
      expect(sondaggi, List<Sondaggio>.empty(growable: true));

      final utente = await service.prelevaCredenziali();
      expect(utente, const Utente("mario.rossi@regione.tn.it", "rcuuyqtf"));
    },
  );
}
