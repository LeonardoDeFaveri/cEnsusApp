import 'package:census/classes/sondaggio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SurveyPage extends StatefulWidget {
  final Sondaggio sondaggio;
  const SurveyPage(this.sondaggio, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nuovo sondaggio"),
      ),
      body: const Center(
        child: Text("Nuovo sondaggio"),
      ),
    );
  }
}
