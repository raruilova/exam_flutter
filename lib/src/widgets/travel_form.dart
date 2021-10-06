import 'package:examen2p_ruilova/src/model/travel_model.dart';
import 'package:examen2p_ruilova/src/providers/travel_provider.dart';
import 'package:examen2p_ruilova/src/utils/standar_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class TravelForm extends StatefulWidget {
  TravelForm({Key? key}) : super(key: key);

  @override
  _TravelFormState createState() => _TravelFormState();
}

class _TravelFormState extends State<TravelForm> {
  final formKey = GlobalKey<FormState>();
  late Travel _element;
  bool _onSaving = false;

  DateTime _date = DateTime(2020, 11, 17);

  

  @override
  void initState() {
    super.initState();
    _element = Travel.create("","", "", DateTime.now());
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            width: size.width * .80,
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Theme.of(context).dividerColor)),
            child: Form(
                key: formKey,
                child: Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 2.0, horizontal: 14.0),
                  child: Column(
                    children: [_inputs(), _buttons()],
                  ),
                )),
          )
        ],
      ),
    );
  }
   _inputs() {
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 30)),
        TextFormField(
        initialValue: _element.origen,
        onSaved: (value) {
          //Este evento se ejecuta cuando se cumple la validación y cambia el estado del Form
          _element.origen = value.toString();
        },
        validator: (value) {
          if (value!.length < 5) {
            return "Debe ingresar una descripción con al menos 5 caracteres";
          } else {
            return null; //Validación se cumple al retorna null
          }
        },
        decoration: InputDecoration(labelText: "Origen"),
        maxLength: 255,
        maxLines: 2),
        TextFormField(
        initialValue: _element.destino,
        onSaved: (value) {
          //Este evento se ejecuta cuando se cumple la validación y cambia el estado del Form
          _element.destino = value.toString();
        },
        validator: (value) {
          if (value!.length < 5) {
            return "Debe ingresar una descripción con al menos 5 caracteres";
          } else {
            return null; //Validación se cumple al retorna null
          }
        },
        decoration: InputDecoration(labelText: "Destino"),
        maxLength: 255,
        maxLines: 2),
        TextFormField(
        initialValue: _element.recorrido.toString(),
        onSaved: (value) {
          //Este evento se ejecuta cuando se cumple la validación y cambia el estado del Form
          _element.recorrido = value.toString();
        },
        validator: (value) {
          if (value!.length < 1) {
            return "Debe ingresar una descripción con al menos 1 caracteres";
          } else {
            return null; //Validación se cumple al retorna null
          }
        },
        decoration: InputDecoration(labelText: "Recorrido"),
        maxLength: 255,
        maxLines: 2),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _selectDate,
              child: Text('Escoje la fecha'),
            )
          ],
        )
        

      ],
    );
  }

  _buttons() {
    return _onSaving
        ? Container(
            height: 50.0,
            width: 50.0,
            child: Center(child: CircularProgressIndicator()))
        : Tooltip(
            message: "Guardar",
            child: ElevatedButton(
              onPressed: () {
                _sendForm();
              },
              child: Icon(Icons.save),
              style: Standard.buttonStandardStyle(context),
            ),
          );
  }

  _sendForm() {
    if (!formKey.currentState!.validate()) return;
    _onSaving = true;
    setState(() {});

    formKey.currentState!.save();

    final travelProvider =
        Provider.of<TravelProvider>(context, listen: false);
    travelProvider.addElement(_element.origen,_element.destino, _element.recorrido, _element.fecha).then((value) {
      _element = value;
      formKey.currentState!.reset();
      _onSaving = false;
      setState(() {});
    });
  }
  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _element.fecha,
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(2022, 7),
      helpText: 'Selecciona una fecha',
      initialEntryMode: DatePickerEntryMode.input,
    );
    if (newDate != null) {
      setState(() {
        _element.fecha = newDate;
      });
    }
  }

}