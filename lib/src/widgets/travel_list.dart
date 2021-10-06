import 'package:examen2p_ruilova/src/providers/travel_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TravelList extends StatefulWidget {
  TravelList({Key? key}) : super(key: key);

  @override
  _TravelListState createState() => _TravelListState();
}

class _TravelListState extends State<TravelList> {
  @override
  Widget build(BuildContext context) {
    final travelProvider = Provider.of<TravelProvider>(context, listen: false);
    travelProvider.loadElements();
    return travelProvider.elements.length == 0
        ? Center(
            child: Container(
              //height: 100,
              width: 100,
              child: CircularProgressIndicator(),
            ),
          )
        : ListView.builder(
          padding: EdgeInsets.only(top: 25.0),
            //shrinkWrap: true,
            itemCount: travelProvider.elements.length,
            itemBuilder: (_, index) => Card(
               shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                          elevation: 10,
                child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.place),
                  title:
                      Text('Origen: ' + travelProvider.elements[index].origen),
                  subtitle:
                      Text(travelProvider.elements[index].fecha.toString()),
                ),
                ListTile(
                  title: Text(
                      'Destino: ' + travelProvider.elements[index].destino),
                  subtitle: Text('Recorrido: ' +
                      travelProvider.elements[index].recorrido.toString()+'Km'),
                ),

                // Padding(padding: EdgeInsets.all(10.0),
                //child: Text(travelProvider.elements[index].recorrido),
                //),
              ],
            )),
          );
  }
}
