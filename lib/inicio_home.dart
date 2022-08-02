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
  bool isEnabled=false;

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
               Container(
                width: 200,
                child: campoPeso()),
                const SizedBox(width: 20),
              ElevatedButton(onPressed: (){
                setState(() {
                  isEnabled=true;
                });
                  
              }, child: Text(' USD => Peso')),
                const SizedBox(width: 20),
              Container(
                width: 200,
                child: campoDolar()),
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
            _cambioDivisa(peso_c.text);
          });
        },
        child: const Text('Cambio'));
  }

  TextField campoPeso() {
    return TextField(
       enabled: !isEnabled,
        keyboardType: TextInputType.number,
        controller: peso_c,
        decoration: const InputDecoration(
          labelText: 'Peso',
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ));
  }

   TextField campoDolar() {
    return TextField(
      enabled: isEnabled,
        keyboardType: TextInputType.number,
        controller: dolar_c,
        decoration: const InputDecoration(
          labelText: 'USD',
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ));
  }


  void _cambioDivisa(String p) {
    if (!isEnabled){
double peso = double.parse(p);
    dolar_c.text = (peso / double.parse(precioDolarBlue)).toStringAsFixed(3);
    }else{
      
      peso_c.text= (double.parse(dolar_c.text)* double.parse(precioDolarBlue)).toStringAsFixed(3);
    }
    
  }
}
