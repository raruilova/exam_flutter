import 'package:examen2p_ruilova/src/model/travel_model.dart';
import 'package:flutter/material.dart';


import 'db_provider.dart';

class TravelProvider extends ChangeNotifier {
  List<Travel> elements = [];

  Future<Travel> addElement(String origen, String destino, String recorrido, DateTime fecha) async {
    Travel element = Travel(origen: origen, destino: destino, recorrido: recorrido, fecha: fecha);
    final id = await DBProvider.db.insert(element);
    element.id = id;
    this.elements.add(element);
    notifyListeners();
    return element;
  }

  loadElements() async {
    final practiceQuery = await DBProvider.db.list();
    this.elements = [...practiceQuery];
    notifyListeners();
  }
}