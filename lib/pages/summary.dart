import 'package:census/classes/sondaggio.dart';
import 'package:census/pages/drafts_list.dart';
import 'package:census/pages/models.dart';
import 'package:flutter/material.dart';

class SummaryPage extends StatelessWidget {
  Sondaggio sondaggio;

  SummaryPage(this.sondaggio, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riepilogo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  child: ListTile(
                    title: Text(
                        sondaggio.risposteSelezionate[index].domanda.testo),
                    onTap: () {},
                  ),
                  color: (sondaggio.risposteSelezionate[index].risposta == null)
                      ? Colors.red
                      : Colors.green,
                );
              },
            ),
            Visibility(
                visible: sondaggio.isCompletato(),
                child: ElevatedButton(
                  onPressed: () => {},
                  child: const Text("Conferma"),
                )),
            ElevatedButton(
              onPressed: () => {},
              child: const Text("Salva Bozza"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Indietro"),
            ),
          ],
        ),
      ),
    );
  }
}
