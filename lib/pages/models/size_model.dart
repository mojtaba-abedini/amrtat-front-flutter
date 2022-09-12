import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../api.dart';
import 'dart:convert';

class SizeModel with ChangeNotifier {
  String _jens = "";
  String _karbari = "";

  late String name;

  List _loadedJens = [];
  List _loadedKarbari = [];
  List _filterKarbari = [];

  getLoadedJens() => _loadedJens;

  getJens() => _jens;

  getKarbari() => _karbari;
  getFilterKarbari() => _filterKarbari;


  setLoadedJens(List loadedJens) => _loadedJens = loadedJens;
  setLoadedKarbari(List loadedKarbari) => _loadedKarbari = loadedKarbari;

  void readJens(String value) {
    _jens = value;
    notifyListeners();
    print(_loadedJens);
    _filterKarbari =  _loadedKarbari.where((o) => o['jens_id'] == 1).toList();
    print(_filterKarbari);
  }

  void readKarbari(String value) {
    _karbari = value;
    notifyListeners();
    print(_karbari);
  }


}
