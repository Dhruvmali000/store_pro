// ignore_for_file: non_constant_identifier_names, avoid_dynamic_calls

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:store_pro/product_store/model/icecream.dart';

class ProductRepo {
  static Future<List<Icecreams>> loadAllIcreams() async {
    final res = await rootBundle.loadString('assets/icecream.json');
    final iceCreamData = IceCreamData.fromJson(
      json.decode(res) as Map<String, dynamic>,
    );
    return iceCreamData.icecreams!;
  }
}
