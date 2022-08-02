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
  final pesoc = TextEditingController();
  final dolarc = TextEditingController();
  String precioDolarBlue = '';
  bool isEnabled = false;

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 200, child: campoPeso()),
              const SizedBox(width: 20),
              IconButton(
                icon: Image.asset('android/assets/images/changedolar.png'),
                iconSize: 50,
                onPressed: () {
                  setState(() {
                    dolarc.text = '';
                    pesoc.text = '';
                    if (!isEnabled) {
                      isEnabled = true;
                    } else {
                      isEnabled = false;
                    }
                  });
                },
              ),
              const SizedBox(width: 20),
              Container(width: 200, child: campoDolar()),
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
            return Text('Precio Dolar Blue: ${snapshot.data!.blue!.valueBuy}');
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
            _cambioDivisa();
          });
        },
        child: const Text('Cambio'));
  }

  TextField campoPeso() {
    return TextField(
        enabled: !isEnabled,
        keyboardType: TextInputType.number,
        controller: pesoc,
        decoration: const InputDecoration(
          labelText: 'Peso',
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ));
  }

  TextField campoDolar() {
    return TextField(
        enabled: isEnabled,
        keyboardType: TextInputType.number,
        controller: dolarc,
        decoration: const InputDecoration(
          labelText: 'USD',
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ));
  }

  void _cambioDivisa() {
    if (!isEnabled) {
      dolarc.text = (double.parse(pesoc.text) / double.parse(precioDolarBlue))
          .toStringAsFixed(3);
    } else {
      pesoc.text = (double.parse(dolarc.text) * double.parse(precioDolarBlue))
          .toStringAsFixed(3);
    }
  }
}
