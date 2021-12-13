import 'package:census/classes/gestore_memoria_locale.dart';
import 'package:census/classes/modello.dart';
import 'package:census/classes/sondaggio.dart';
import 'package:census/pages/summary.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class SurveyPage extends StatefulWidget {
  final Sondaggio sondaggio;
  final int indiceDomanda;

  const SurveyPage(this.sondaggio, this.indiceDomanda, {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  final GestoreMemoriaLocale _service = GestoreMemoriaLocale();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Risposta? _risposta;
  late int _indiceDomanda;
  late bool _policyAccettata;

  @override
  void initState() {
    super.initState();
    _indiceDomanda = widget.indiceDomanda - 1;
    _policyAccettata = widget.sondaggio.isInformativaAccettata();
  }

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
    if (_indiceDomanda == -1) {
      return _privacyPolicyView();
    }
    Domanda domanda = widget.sondaggio.modello.domande[_indiceDomanda];
    _risposta = widget.sondaggio.risposteSelezionate[_indiceDomanda].risposta;
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
                          widget.sondaggio.seleziona(domanda, value!);
                          if (_isCompletato()) {
                            widget.sondaggio.setCompletato();
                          }
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
                    onPressed: (_indiceDomanda != 0)
                        ? () {
                            setState(() {
                              _indiceDomanda--;
                            });
                          }
                        : null,
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
                            builder: (context) => SummaryPage(widget.sondaggio),
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
                    onPressed: (_indiceDomanda !=
                            widget.sondaggio.risposteSelezionate.length - 1)
                        ? () {
                            setState(() {
                              _indiceDomanda++;
                            });
                          }
                        : null,
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

  Widget _privacyPolicyView() {
    return Stack(
      fit: StackFit.expand,
      alignment: AlignmentDirectional.centerStart,
      children: [
        SafeArea(child: SfPdfViewer.file(_service.prelevaPathInformativa())),
        /*Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckboxListTile(
              value: _policyAccettata,
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    widget.sondaggio.accettaInformativa();
                  }
                });
              },
              title: const Text(
                  "Dichiaro di aver letto e compreso i termini presentati"),
            ),
            ElevatedButton(
              child: const Text("Prosegui"),
              onPressed: _policyAccettata
                  ? () {
                      _indiceDomanda++;
                    }
                  : null,
            ),
          ],
        )*/
      ],
    );
  }

  bool _isCompletato() {
    int numeroRisposteDate = 0;
    for (var risposta in widget.sondaggio.risposteSelezionate) {
      if (risposta.risposta != null) {
        numeroRisposteDate++;
      }
    }
    return numeroRisposteDate == widget.sondaggio.risposteSelezionate.length;
  }
}
