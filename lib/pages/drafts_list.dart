import 'package:census/classes/gestore_memoria_locale.dart';
import 'package:census/classes/sondaggio.dart';
import 'package:census/classes/utente.dart';
import 'package:flutter/material.dart';

class DraftsListPage extends StatefulWidget {
  const DraftsListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DrafsListPageState();
}

class _DrafsListPageState extends State<DraftsListPage> {
  final GestoreMemoriaLocale _service = GestoreMemoriaLocale();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista bozze"),
      ),
      body: Center(
        child: FutureBuilder(
          future: _service.prelevaBozze(const Utente("", "")),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            List<Sondaggio> bozze = snapshot.data as List<Sondaggio>;
            if (bozze.isEmpty) {
              return const Text("Non hai ancora salvato nessuna bozza");
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      "Sondaggio: ${bozze.elementAt(index).id.toString()}"),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
