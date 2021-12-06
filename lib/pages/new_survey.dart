import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SurveyPage extends StatefulWidget {
  const SurveyPage({Key? key}) : super(key: key);

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
