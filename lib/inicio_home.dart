import 'package:dolarblue/api/dolar_api.dart';
import 'package:dolarblue/model/dolar_model.dart';
import 'package:flutter/material.dart';

class Inicio extends StatelessWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final peso_c = TextEditingController();
  final dolar_c = TextEditingController();
  String precioDolarBlue = '';

  Future<DolarModel> _dolarBlue() {
    return DolarApi().fetchDolar();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          precioDolar(),
          Row(
            children: [
              campo(l: '\$', peso_c),
              campo(dolar_c),
            ],
          ),
          const SizedBox(height: 20),
          boton(),
        ],
      ),
    );
  }

  FutureBuilder<DolarModel> precioDolar() {
    return FutureBuilder<DolarModel>(
        future: _dolarBlue(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            precioDolarBlue = snapshot.data!.blue!.valueBuy.toString();
            return Text(snapshot.data!.blue!.valueBuy.toString());
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Container();
        });
  }

  ElevatedButton boton() {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            _cambioDivisa(peso_c.text);
          });
        },
        child: const Text('Cambio'));
  }

  TextField campo(TextEditingController controller, {String l = 'USD'}) {
    return TextField(
        keyboardType: TextInputType.number,
        controller: controller,
        decoration: InputDecoration(
          labelText: l,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ));
  }

  void _cambioDivisa(String p) {
    double peso = double.parse(p);
    dolar_c.text = (peso / double.parse(precioDolarBlue)).toString();
  }
}
