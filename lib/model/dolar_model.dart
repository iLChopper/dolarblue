class DolarModel {
  Oficial? oficial;
  Oficial? blue;
  OficialEuro? oficialEuro;
  Oficial? blueEuro;
  String? lastUpdate;

  DolarModel(
      {this.oficial,
      this.blue,
      this.oficialEuro,
      this.blueEuro,
      this.lastUpdate});

  DolarModel.fromJson(Map<String, dynamic> json) {
    oficial =
        json['oficial'] != null ? new Oficial.fromJson(json['oficial']) : null;
    blue = json['blue'] != null ? new Oficial.fromJson(json['blue']) : null;
    oficialEuro = json['oficial_euro'] != null
        ? new OficialEuro.fromJson(json['oficial_euro'])
        : null;
    blueEuro = json['blue_euro'] != null
        ? new Oficial.fromJson(json['blue_euro'])
        : null;
    lastUpdate = json['last_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.oficial != null) {
      data['oficial'] = this.oficial!.toJson();
    }
    if (this.blue != null) {
      data['blue'] = this.blue!.toJson();
    }
    if (this.oficialEuro != null) {
      data['oficial_euro'] = this.oficialEuro!.toJson();
    }
    if (this.blueEuro != null) {
      data['blue_euro'] = this.blueEuro!.toJson();
    }
    data['last_update'] = this.lastUpdate;
    return data;
  }
}

class Oficial {
  double? valueAvg;
  double? valueSell;
  double? valueBuy;

  Oficial({this.valueAvg, this.valueSell, this.valueBuy});

  Oficial.fromJson(Map<String, dynamic> json) {
    valueAvg = json['value_avg'];
    valueSell = json['value_sell'];
    valueBuy = json['value_buy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value_avg'] = this.valueAvg;
    data['value_sell'] = this.valueSell;
    data['value_buy'] = this.valueBuy;
    return data;
  }
}

class OficialEuro {
  int? valueAvg;
  double? valueSell;
  double? valueBuy;

  OficialEuro({this.valueAvg, this.valueSell, this.valueBuy});

  OficialEuro.fromJson(Map<String, dynamic> json) {
    valueAvg = json['value_avg'];
    valueSell = json['value_sell'];
    valueBuy = json['value_buy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value_avg'] = this.valueAvg;
    data['value_sell'] = this.valueSell;
    data['value_buy'] = this.valueBuy;
    return data;
  }
}
