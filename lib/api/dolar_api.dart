import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../model/dolar_model.dart';

class DolarApi {
  Future<DolarModel> fetchDolar() async {
    final response =
        await http.get(Uri.parse('https://api.bluelytics.com.ar/v2/latest'));

    if (response.statusCode == 200) {
      // Si la llamada al servidor fue exitosa, analiza el JSON
      return DolarModel.fromJson(json.decode(response.body));
    } else {
      // Si la llamada no fue exitosa, lanza un error.
      throw Exception('Error al cargar los datos');
    }
  }
}
