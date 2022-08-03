import 'package:dolarblue/api/dolar_api.dart';
import 'package:dolarblue/model/dolar_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.white),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.amberAccent),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.amberAccent),
            ),
            disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white38))),
        textTheme: const TextTheme(
            /*  headline1:
               
           TextStyle(
              fontFamily:  
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87),*/
            subtitle1: TextStyle(color: Colors.white, fontSize: 25)),
      ),
      home: Scaffold(
        backgroundColor: Colors.amberAccent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
                width: 300,
                height: 300,
                margin: const EdgeInsets.only(top: 70),
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(53, 55, 88, 1),
                    shape: BoxShape.circle),
                child: Center(child: precioDolar())),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 100),
                padding: const EdgeInsets.only(top: 120),
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(53, 55, 88, 1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(37.5),
                      topRight: Radius.circular(37.5),
                    )),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 60, child: campoPeso()),
                        const SizedBox(width: 20),
                        IconButton(
                          splashColor: Colors.white,
                          icon: Image.asset(
                              'android/assets/images/changedolar.png'),
                          iconSize: 50,
                          highlightColor: Colors.white,
                          tooltip: 'Cambio',
                          onPressed: () {
                            setState(() {
                              dolarc.text = '';
                              pesoc.text = '';
                              isEnabled = !isEnabled;
                            });
                          },
                        ),
                        const SizedBox(width: 20),
                        SizedBox(width: 60, child: campoDolar()),
                      ],
                    ),
                    const SizedBox(height: 50),
                    boton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  FutureBuilder<DolarModel> precioDolar() {
    return FutureBuilder<DolarModel>(
        future: _dolarBlue(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            precioDolarBlue = snapshot.data!.blue!.valueBuy.toString();
            return Text(
              '${snapshot.data!.blue!.valueBuy}\n Dolar Blue',
              style: GoogleFonts.pacifico(
                  textStyle:
                      const TextStyle(color: Colors.white, fontSize: 40)),
              textAlign: TextAlign.center,
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const CircularProgressIndicator();
        });
  }

  ElevatedButton boton() {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            _cambioDivisa();
          });
        },
        child: const Text('Calcular'));
  }

  TextField campoPeso() {
    return TextField(
        autofocus: true,
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
