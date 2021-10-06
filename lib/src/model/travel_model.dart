// To parse this JSON data, do
//
//     final travel = travelFromJson(jsonString);

import 'dart:convert';

Travel travelFromJson(String str) => Travel.fromJson(json.decode(str));

String travelToJson(Travel data) => json.encode(data.toJson());

class Travel {
    Travel({
        this.id,
        required this.origen,
        required this.destino,
        required this.recorrido,
        required this.fecha
    });

    int? id;
    String origen;
    String destino;
    String recorrido;
    DateTime fecha;

    Travel.create(this.origen, this.destino, this.recorrido, this.fecha);

    factory Travel.fromJson(Map<String, dynamic> json) => Travel(
        id: json["id"],
        origen: json["origen"],
        destino: json["destino"],
        recorrido: json["recorrido"],
        fecha: DateTime.parse(json["fecha"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "origen": origen,
        "destino": destino,
        "recorrido": recorrido,
         "fecha":
            "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
    };
}
