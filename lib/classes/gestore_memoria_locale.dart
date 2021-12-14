import 'dart:convert';
import 'dart:io';

import 'package:census/classes/modello.dart';
import 'package:census/classes/sondaggio.dart';
import 'package:census/classes/utente.dart';
import 'package:census/classes/util.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class GestoreMemoriaLocale {
  final String _pathCredenziali = "data/credenziali.json";
  final String _pathSondaggi = 'data/sondaggi/';
  final String _pathBozze = 'data/bozze/';
  final String _pathModelli = 'data/modelli/';
  final String _pathInformativa = 'data/informativa/privacy.pdf';

  String get pathInformativa => _pathInformativa;

  Future<Utente> prelevaCredenziali() async {
    final String credentials = await rootBundle.loadString(_pathCredenziali);
    final json = jsonDecode(credentials);
    return Utente.fromJson(json);
  }

  Future<void> salvaCredenziali(Utente utente) async {
    final json = utente.toJson();
    final credentials = jsonEncode(json);
    final file = File(_pathCredenziali);
    file.writeAsString(credentials);
  }

  Future<List<Sondaggio>> prelevaSondaggi() async {
    final List<Sondaggio> sondaggi = List<Sondaggio>.empty(growable: true);
    final manifestJson = await rootBundle.loadString('AssetManifest.json');
    final files = json
        .decode(manifestJson)
        .keys
        .where((String key) => key.startsWith(_pathSondaggi));
    for (String file in files) {
      var excel = await _openExcel(file);
      try {
        sondaggi.add(Sondaggio.fromExcel(excel));
      } on ExcelException {
        stderr.writeln('Invalid excel file: $file');
      }
    }

    return sondaggi;
  }

  Future<List<Sondaggio>> prelevaBozze() async {
    final List<Sondaggio> bozze = List<Sondaggio>.empty(growable: true);
    final manifestJson = await rootBundle.loadString('AssetManifest.json');
    final files = json
        .decode(manifestJson)
        .keys
        .where((String key) => key.startsWith(_pathBozze));
    for (String file in files) {
      var excel = await _openExcel(file);
      try {
        bozze.add(Sondaggio.fromExcel(excel));
      } on ExcelException {
        stderr.writeln('Invalid excel file: $file');
      }
    }

    return bozze;
  }

  Future<List<Modello>> prelevaModelli() async {
    final List<Modello> modelli = List<Modello>.empty(growable: true);
    final manifestJson = await rootBundle.loadString('AssetManifest.json');
    final files = json
        .decode(manifestJson)
        .keys
        .where((String key) => key.startsWith(_pathModelli));
    for (String file in files) {
      var excel = await _openExcel(file);
      try {
        modelli.add(Modello.fromExcel(excel));
      } on ExcelException {
        stderr.writeln('Invalid excel file: $file');
      }
    }

    return modelli;
  }

  void salvaSondaggio(Sondaggio sondaggio) async {
    final excel = Excel.createExcel();
    const sheet = "sheet1";
    final header = List.empty(growable: true);
    header.add("Modello");
    header.add(sondaggio.modello.id);
    header.add(sondaggio.modello.nome);
    header.add(sondaggio.descrizione);
    header.add(DateTime.now().millisecondsSinceEpoch);
    header.add(true);
    header.add(true);
    excel.appendRow(sheet, header);

    for (var domandaRisposta in sondaggio.risposteSelezionate) {
      final row = List.empty(growable: true);
      row.add(domandaRisposta.domanda.testo);
      row.add(domandaRisposta.risposta?.testo);
      for (var risposta in domandaRisposta.domanda.risposte) {
        row.add(risposta.testo);
      }
      excel.appendRow(sheet, row);
    }
    final path = await _localPath;

    return;
  }

  Future<Excel> _openExcel(String path) async {
    ByteData data = await rootBundle.load(path);
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);
    return excel;
  }

  Future<String> get _localPath async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    return appDocPath;
  }
}
