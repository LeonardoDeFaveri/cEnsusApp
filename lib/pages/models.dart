import 'package:census/classes/gestore_memoria_locale.dart';
import 'package:census/classes/modello.dart';
import 'package:census/classes/sondaggio.dart';
import 'package:census/pages/new_survey.dart';
import 'package:flutter/material.dart';

class ModelsPage extends StatelessWidget {
  final _service = GestoreMemoriaLocale();
  final _textFieldController = TextEditingController();

  ModelsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String descrizione = "";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scelta modello"),
      ),
      body: Center(
        child: FutureBuilder(
          future: _service.prelevaModelli(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            List<Modello> modelli = snapshot.data as List<Modello>;
            if (modelli.isEmpty) {
              return const Text(
                "Non hai ancora nessun modello tra cui scegliere",
              );
            }
            return ListView.builder(
              itemCount: modelli.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(modelli[index].nome),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text(
                            "Indica una descrizione per il sondaggio"),
                        content: TextField(
                          controller: _textFieldController,
                          decoration:
                              const InputDecoration(hintText: "Descrizione"),
                          onChanged: (value) {
                            descrizione = value;
                          },
                        ),
                        actions: [
                          ElevatedButton(
                            child: const Text("Annulla"),
                            onPressed: () {
                              descrizione = "";
                              Navigator.pop(context);
                            },
                          ),
                          ElevatedButton(
                            child: const Text("Conferma"),
                            onPressed: () {
                              final sondaggio =
                                  Sondaggio.newSurvey(modelli[index]);
                              sondaggio.descrizione = descrizione;
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SurveyPage(
                                      Sondaggio.newSurvey(modelli[index]), 0),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      barrierDismissible: false,
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
