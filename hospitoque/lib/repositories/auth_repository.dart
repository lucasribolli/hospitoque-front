import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:hospitoque/repositories/constants.dart';

class AuthRepository {
  AuthRepository._();

  static Future<bool> auth(String email) async {
    var dio = Dio();
    var response = await dio.get('$Constants.BASE_URL/auth?email=$email');
    debugPrint('response.data -> ${response.data}');
    return false;
  }
}