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

  /// ottiene il percorso dell'informativa sulla privacy salvata in memoria
  String get pathInformativa => _pathInformativa;

  /// restituisce le credenziali dell'utente 
  /// 
  /// accede alla memoria per prelevare le credenziali e le restituisce come file JSON
  Future<Utente> prelevaCredenziali() async {
    final String credentials = await rootBundle.loadString(_pathCredenziali);
    final json = jsonDecode(credentials);
    return Utente.fromJson(json);
  }

  /// salva in memoria le credenziali dell'utente
  /// 
  /// le credenziali vengono passate tramite [utente], un'istanza della classe Utente
  Future<void> salvaCredenziali(Utente utente) async {
    final json = utente.toJson();
    final credentials = jsonEncode(json);
    final file = File(_pathCredenziali);
    file.writeAsString(credentials);
  }

  /// preleva dalla memoria tutti i sondaggi completati
  /// 
  /// i sondaggi vengono restituiti in una lista di sondaggi
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

  /// restituisce tutte le bozze salvate in memoria
  /// 
  /// vengono letti i file excel delle bozze salvate in memoria e viene restituita una lista di istanze di Sondaggio
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

  /// restituisce i modelli salvati in memoria
  /// 
  /// vengono letti i file excel dei modelli salvati in memoria e viene restituita una lista di istanze di Modello
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

  /// salva un sondaggio in memoria sotto forma di file excel
  /// 
  /// prende come parametro [sondaggio], un'istanza della classe Sondaggio che contiene i dati del sondaggio da salvare in memoria
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
    final fileName =
        "risposta_modello_${sondaggio.modello.id}_${sondaggio.dataOra}";
    final path = await _localPath;

    return;
  }

  /// riceve il path di un file excel, legge il file e restituisce un'istanza di esso
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
