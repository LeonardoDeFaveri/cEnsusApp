import 'package:census/pages/drafts_list.dart';
import 'package:census/pages/new_survey.dart';
import 'package:flutter/material.dart';

class SurveysPage extends StatelessWidget {
  const SurveysPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menù sondaggi"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SurveyPage(),
                    ),
                  )
                },
                child: const Text("Nuovo sondaggio"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DraftsListPage()),
                  )
                },
                child: const Text("Lista bozze"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () => {Navigator.pop(context)},
                child: const Text("Indietro"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
