import 'package:flutter/material.dart';
class Inicio extends StatelessWidget {
const Inicio({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return  MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
          
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                child:  Text('Pantalla de Inicio'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}