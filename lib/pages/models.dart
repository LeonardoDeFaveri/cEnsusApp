import 'package:census/classes/gestore_memoria_locale.dart';
import 'package:census/classes/modello.dart';
import 'package:census/classes/sondaggio.dart';
import 'package:census/pages/new_survey.dart';
import 'package:flutter/material.dart';

class ModelsPage extends StatelessWidget {
  final _service = GestoreMemoriaLocale();

  ModelsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                  "Non hai ancora nessun modello tra cui scegliere");
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(modelli[index].nome),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SurveyPage(Sondaggio.newSurvey(modelli[index])),
                      ),
                    );
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_forever),
                    onPressed: () {},
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
