import 'package:census/classes/modello.dart';
import 'package:census/classes/sondaggio.dart';
import 'package:census/pages/privacy_policy.dart';
import 'package:census/pages/summary.dart';
import 'package:flutter/material.dart';

class SurveyPage extends StatefulWidget {
  final Sondaggio sondaggio;
  final int indiceDomanda;

  const SurveyPage(this.sondaggio, this.indiceDomanda, {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Risposta? _risposta;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Compilazione sondaggio"),
      ),
      body: Center(
        child: _buildPage(),
      ),
    );
  }

  Widget _buildPage() {
    int indiceDomanda = widget.indiceDomanda - 1;

    if (indiceDomanda == -1) {
      return PrivacyPolicy();
    } else {
      Domanda domanda = widget.sondaggio.modello.domande[indiceDomanda];
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 8.0,
              bottom: 8.0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        domanda.testo,
                        textAlign: TextAlign.start,
                        textScaleFactor: 1.5,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: domanda.risposte.length,
                    itemBuilder: (context, index) {
                      return RadioListTile(
                        title: Text(domanda.risposte[index].testo),
                        value: domanda.risposte[index],
                        groupValue: _risposta,
                        onChanged: (Risposta? value) {
                          setState(() {
                            _risposta = value;
                          });
                        },
                        selected: _risposta == domanda.risposte[index],
                        selectedTileColor: Colors.yellow,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_outlined),
                      onPressed: () {
                        //_formKey.currentState!.save();
                      },
                    ),
                    const Text(
                      "Domanda precedente",
                      style: TextStyle(color: Colors.red),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SummaryPage(widget.sondaggio),
                            ),
                          );
                        },
                        child: const Text("Riepilogo"),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_outlined),
                      onPressed: () {
                        //_formKey.currentState!.save();
                      },
                    ),
                    const Text(
                      "Domanda successiva",
                      style: TextStyle(color: Colors.red),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text("Salva come bozza"),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }
  }
}
