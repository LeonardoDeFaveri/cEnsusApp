import 'dart:convert';
import 'dart:io';

import 'package:census/classes/sondaggio.dart';
import 'package:census/classes/utente.dart';
import 'package:flutter/services.dart';

class GestoreMemoriaLocale {
  final String pathCredenziali = "data/credenziali.json";
  final String pathSondaggi = 'data/sondaggi/';
  final String pathBozze = 'data/bozze/';

  Future<Utente> prelevaCredenziali() async {
    final String credentials = await rootBundle.loadString(pathCredenziali);
    final json = jsonDecode(credentials);
    return Utente.fromJson(json);
  }

  Future<void> salvaCredenziali(Utente utente) async {
    final json = utente.toJson();
    final credentials = jsonEncode(json);
    final file = File(pathCredenziali);
    file.writeAsString(credentials);
  }

  Future<List<Sondaggio>> prelevaSondaggi(Utente utente) async {
    final List<Sondaggio> sondaggi = List<Sondaggio>.empty();
    final Directory dir = Directory(pathSondaggi);
    dir.list(recursive: false).forEach((file) {
      sondaggi.add(Sondaggio.fromExcel(utente, file.path));
    });
    return sondaggi;
  }

  Future<List<Sondaggio>> prelevaBozze(Utente utente) async {
    final List<Sondaggio> bozze = List<Sondaggio>.empty();
    final Directory dir = Directory(pathBozze);
    dir.list(recursive: false).forEach((file) {
      bozze.add(Sondaggio.fromExcel(utente, file.path));
    });
    return bozze;
  }
}
