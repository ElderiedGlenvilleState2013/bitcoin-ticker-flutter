

import 'dart:ffi';

class CurrencyModel {
  DateTime time;
  String asset_id_base;
  String asset_id_quote;
  Double rate;

  CurrencyModel(this.time, this.asset_id_base, this.asset_id_quote, this.rate);

}