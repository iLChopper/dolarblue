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
          FutureBuilder<DolarModel>(
              future: _dolarBlue(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  precioDolarBlue = snapshot.data!.blue!.valueBuy.toString();
                  return Text(snapshot.data!.blue!.valueBuy.toString());
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return Container();
              }),
          TextField(
              keyboardType: TextInputType.number,
              controller: peso_c,
              decoration: const InputDecoration(
                labelText: 'Peso',
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              )),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _cambioDivisa(peso_c.text);
                });
              },
              child: const Text('Cambio')),
          const SizedBox(height: 20),
          TextField(
              controller: dolar_c,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'USD',
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ))
        ],
      ),
    );
  }

  void _cambioDivisa(String p) {
    double peso = double.parse(p);
    dolar_c.text = (peso / double.parse(precioDolarBlue)).toString();
  }
}
