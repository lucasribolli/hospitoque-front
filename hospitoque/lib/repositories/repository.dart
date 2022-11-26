import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hospitoque/model/medicine.dart';
import 'package:hospitoque/repositories/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HospitoqueRepository {
  HospitoqueRepository._();

  static const String _EMAIL_USER_PREFERENCES_KEY = 'email_key';

  static Future<bool> auth(String email) async {
    var dio = Dio();
    var response = await dio.get('${Constants.BASE_URL}/auth?email=$email');
    debugPrint('response.data -> ${response.data}');
    bool isAuthorized = response.data['authorized'];
    return isAuthorized;
  }

  static Future<List<Medicine>> getMedicines({String keyword = ''}) async {
    var dio = Dio();
    var response = await dio.get('${Constants.BASE_URL}/medicine?q=$keyword');
    List<dynamic> medicinesResponse = response.data;
    // return mockedMedicines();
    return medicinesResponse.map((m) => Medicine.fromMap(m)).toList();
  }

  static Future<void> addMedicine(Medicine medicine) async {
    var dio = Dio();
    var response = await dio.post(
      '${Constants.BASE_URL}/medicine',
      data: medicine.toMap(),
    );
    debugPrint('addMedicine response -> ${response.data}');
  }

  static Future<String?> signIn() async {
    var account = await GoogleSignIn().signIn();
    return account?.email;
  }

  static Future<void> saveEmail(String email) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(_EMAIL_USER_PREFERENCES_KEY, email);
  }

  static Future<String?> getEmail() async {
    if(await GoogleSignIn().isSignedIn()) {
      debugPrint('isSigned');
      final pref = await SharedPreferences.getInstance();
      String? email = pref.getString(_EMAIL_USER_PREFERENCES_KEY);
      debugPrint('preferences email => $email');
      debugPrint('GoogleSignIn email => ${GoogleSignIn().currentUser?.email}');
        return email;
    }
    return null;
  }

  static Future<void> logout() async {
    await GoogleSignIn().signOut();
    final pref = await SharedPreferences.getInstance();
    await pref.remove(_EMAIL_USER_PREFERENCES_KEY);
  }
}
