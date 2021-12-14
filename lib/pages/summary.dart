import 'package:census/classes/sondaggio.dart';
import 'package:census/pages/new_survey.dart';
import 'package:flutter/material.dart';

class SummaryPage extends StatelessWidget {
  final Sondaggio sondaggio;
  final int indiceChiamante;

  const SummaryPage(this.sondaggio, this.indiceChiamante, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riepilogo"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    SurveyPage(sondaggio, indiceChiamante + 1),
              ),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: sondaggio.risposteSelezionate.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: ListTile(
                      title: Text(
                          sondaggio.risposteSelezionate[index].domanda.testo),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SurveyPage(sondaggio, index + 1),
                          ),
                        );
                      },
                    ),
                    color:
                        (sondaggio.risposteSelezionate[index].risposta == null)
                            ? Colors.red
                            : Colors.green,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SurveyPage(sondaggio, indiceChiamante + 1),
                        ),
                      );
                    },
                    child: const Text("Indietro"),
                  ),
                  ElevatedButton(
                    onPressed: () => {},
                    child: const Text("Salva Bozza"),
                  ),
                  ElevatedButton(
                    onPressed: sondaggio.isCompletato() ? () {} : null,
                    child: const Text("Conferma"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
