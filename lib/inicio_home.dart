

import 'package:dolarblue/api/dolar_api.dart';
import 'package:dolarblue/model/dolar_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Inicio extends StatelessWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
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
           
            subtitle1: TextStyle(color: Colors.white, fontSize: 20)),
      ),
      home: Scaffold(
       
        backgroundColor: Colors.amberAccent,
       
        body: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({
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
 final df =  DateFormat('dd-MM-yyyy hh:mm a');

//Consulta Servicio y devuelve info del Dolar
  Future<DolarModel> _dolarBlue() {
    return DolarApi().fetchDolar();
  }

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Container(
         height:MediaQuery.of(context).size.height,
         width:MediaQuery.of(context).size.width, 
        child: Column(
              
              mainAxisAlignment: MainAxisAlignment.center,          
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: SvgPicture.asset("android/assets/images/dolarsvg.svg")),
                precioDolar(),
               
                 Expanded(
                   child: Container(  
                    padding: const EdgeInsets.only(top:20),
                    margin:const EdgeInsets.only(top:100) ,
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(53, 55, 88, 1),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(37.5),
                            topRight: Radius.circular(37.5),
                          )),
                      child: Column(
                       
                        children: [
                          _camposDatos(),
                          const SizedBox(height: 50),
                          botonCalcular(),
                          const Spacer(),
                          Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text('rodrigo.desarrollador@gmail.com',  style: GoogleFonts.pacifico(
                                textStyle:
                                    const TextStyle(color: Colors.white, fontSize: 20))),
                            ),
                          ), const SizedBox(height: 10)
    
                        ],
                      ),
                    ),
                 ),
               
              ],
           
        ),
      ),
    );
  }

  Row _camposDatos() {
    return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 100, child: campoPeso()),
                            const SizedBox(width: 20),
                            Container(
                              decoration:const BoxDecoration(color:Colors.white, shape: BoxShape.circle) ,
                              child: IconButton(
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
                            ),
                            const SizedBox(width: 20),
                            SizedBox(width: 100, child: campoDolar()),
                          ],
                        );
  }

  FutureBuilder<DolarModel> precioDolar() {
    return FutureBuilder<DolarModel>(
        future: _dolarBlue(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            precioDolarBlue = snapshot.data!.blue!.valueBuy.toString();
            return Column(
              children: [
                SizedBox(
                  height: 50,
                  width: 300,
                  child: Text( textAlign: TextAlign.center,
                    'Dolar Blue: ${snapshot.data!.blue!.valueBuy}',
                    style: GoogleFonts.playfairDisplay(
                        textStyle:
                            const TextStyle(color: Colors.black, fontSize: 25)),
                    
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                 
                  child: Text(
                      'Última Actualización: ${df.format(DateTime.parse(snapshot.data!.lastUpdate!) )}',
                      style: GoogleFonts.montserrat(
                          textStyle:
                              const TextStyle(color: Colors.black, fontSize: 15)),
                      
                    ),
                ),const SizedBox(height: 10),

              ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const CircularProgressIndicator();
        });
  }

  ElevatedButton botonCalcular() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
              fixedSize: const Size(100, 100),
              shape: const CircleBorder(), 
          ),
        onPressed: () {
          setState(() {
            _cambioDivisa();
          });
        },
        child: const Text('Calcular', style: TextStyle(fontSize: 17),));
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
          .toStringAsFixed(1);
    } else {
      pesoc.text = (double.parse(dolarc.text) * double.parse(precioDolarBlue))
          .toStringAsFixed(1);
    }
  }
}
