import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:hospitoque/model/medicine.dart';
import 'package:hospitoque/repositories/constants.dart';

class HospitoqueRepository {
  HospitoqueRepository._();

  static Future<bool> auth(String email) async {
    var dio = Dio();
    var response = await dio.get('${Constants.BASE_URL}/auth?email=$email');
    debugPrint('response.data -> ${response.data}');
    bool isAuthorized = response.data['authorized'];
    return isAuthorized;
  }

  static Future<List<Medicine>> getMedicines() async {
    var dio = Dio();
    var response = await dio.get('${Constants.BASE_URL}/medicine');
    debugPrint('response.data -> ${response.data}');
    List<dynamic> medicinesResponse = response.data;
    return medicinesResponse.map((m) => Medicine.fromMap(m)).toList();
  }
}