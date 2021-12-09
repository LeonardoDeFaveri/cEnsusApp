import 'dart:convert';
import 'dart:io';

import 'package:census/classes/modello.dart';
import 'package:census/classes/sondaggio.dart';
import 'package:census/classes/utente.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart';

class GestoreMemoriaLocale {
  final String _pathCredenziali = "data/credenziali.json";
  final String _pathSondaggi = 'data/sondaggi/';
  final String _pathBozze = 'data/bozze/';
  final String _pathModelli = 'data/modelli/';

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
    final List<Sondaggio> sondaggi = List<Sondaggio>.empty();
    final Directory dir = Directory(_pathSondaggi);
    dir.list(recursive: false).forEach((file) async {
      final excel = await _openExcel(file.path);
      sondaggi.add(Sondaggio.fromExcel(excel));
    });

    return sondaggi;
  }

  Future<List<Sondaggio>> prelevaBozze() async {
    final List<Sondaggio> bozze = List<Sondaggio>.empty();
    final Directory dir = Directory(_pathBozze);
    dir.list(recursive: false).forEach((file) async {
      final excel = await _openExcel(file.path);
      bozze.add(Sondaggio.fromExcel(excel));
    });

    return bozze;
  }

  Future<List<Modello>> prelevaModelli() async {
    final List<Modello> modelli = List<Modello>.empty();
    final Directory dir = Directory(_pathModelli);
    dir.list(recursive: false).forEach((file) async {
      final excel = await _openExcel(file.path);
      modelli.add(Modello.fromExcel(excel));
    });
    return modelli;
  }

  Future<Excel> _openExcel(String path) async {
    ByteData data = await rootBundle.load(path);
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);
    return excel;
  }
}
