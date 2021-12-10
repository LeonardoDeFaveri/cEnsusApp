import 'package:census/classes/gestore_memoria_locale.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PrivacyPolicy extends StatelessWidget {
  PrivacyPolicy({Key? key}) : super(key: key);
  final String title = "Informativa privacy";
  final GestoreMemoriaLocale _service = GestoreMemoriaLocale();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: SfPdfViewer.asset(_service.prelevaPathInformativa()),
      ),
    );
  }
}
