import 'package:census/classes/gestore_memoria_locale.dart';
import 'package:census/classes/sondaggio.dart';
import 'package:census/pages/new_survey.dart';
import 'package:flutter/material.dart';

class DraftsListPage extends StatefulWidget {
  const DraftsListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DraftsListPageState();
}

class _DraftsListPageState extends State<DraftsListPage> {
  final GestoreMemoriaLocale _service = GestoreMemoriaLocale();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista bozze"),
      ),
      body: Center(
        child: FutureBuilder(
          future: _service.prelevaBozze(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            List<Sondaggio> bozze = snapshot.data as List<Sondaggio>;
            if (bozze.isEmpty) {
              return const Text("Non hai ancora salvato nessuna bozza");
            }
            return ListView.builder(
              itemCount: bozze.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(bozze[index].descrizione),
                  subtitle: Text(bozze[index].modello.nome),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SurveyPage(bozze[index], 1),
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
