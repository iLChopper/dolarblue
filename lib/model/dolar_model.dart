class DolarModel {
  Dollar? oficial;
  Dollar? blue;
  OficialEuro? oficialEuro;
  Dollar? blueEuro;
  String? lastUpdate;

  DolarModel(
      {this.oficial,
      this.blue,
      this.oficialEuro,
      this.blueEuro,
      this.lastUpdate});

  DolarModel.fromJson(Map<String, dynamic> json) {
    oficial =
        json['oficial'] != null ?  Dollar.fromJson(json['oficial']) : null;
    blue = json['blue'] != null ?  Dollar.fromJson(json['blue']) : null;
    oficialEuro = json['oficial_euro'] != null
        ?  OficialEuro.fromJson(json['oficial_euro'])
        : null;
    blueEuro = json['blue_euro'] != null
        ?  Dollar.fromJson(json['blue_euro'])
        : null;
    lastUpdate = json['last_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (oficial != null) {
      data['oficial'] = oficial!.toJson();
    }
    if (blue != null) {
      data['blue'] = blue!.toJson();
    }
    if (oficialEuro != null) {
      data['oficial_euro'] = oficialEuro!.toJson();
    }
    if (blueEuro != null) {
      data['blue_euro'] = blueEuro!.toJson();
    }
    data['last_update'] = lastUpdate;
    return data;
  }
}

class Dollar {
  double? valueAvg;
  double? valueSell;
  double? valueBuy;

  Dollar({this.valueAvg, this.valueSell, this.valueBuy});

  Dollar.fromJson(Map<String, dynamic> json) {
    valueAvg = json['value_avg'];
    valueSell = json['value_sell'];
    valueBuy = json['value_buy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['value_avg'] = valueAvg;
    data['value_sell'] = valueSell;
    data['value_buy'] = valueBuy;
    return data;
  }
}

class OficialEuro {
  double? valueAvg;
  double? valueSell;
  double? valueBuy;

  OficialEuro({this.valueAvg, this.valueSell, this.valueBuy});

  OficialEuro.fromJson(Map<String, dynamic> json) {
    valueAvg = json['value_avg'];
    valueSell = json['value_sell'];
    valueBuy = json['value_buy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['value_avg'] = valueAvg;
    data['value_sell'] = valueSell;
    data['value_buy'] = valueBuy;
    return data;
  }
}
