import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hospitoque/model/discard_medicine.dart';
import 'package:hospitoque/model/medicine.dart';
import 'package:hospitoque/repositories/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HospitoqueRepository {
  HospitoqueRepository._();

  static final _dio = Dio();

  static const String _EMAIL_USER_PREFERENCES_KEY = 'email_key';

  static Future<bool> auth(String email) async {
    var response = await _dio
        .get('${Constants.BASE_URL}/${Constants.API_AUTH_ROUTE}?email=$email');
    debugPrint('response.data -> ${response.data}');
    bool isAuthorized = response.data['authorized'];
    return isAuthorized;
  }

  static Future<List<Medicine>> getMedicines({String keyword = ''}) async {
    // return medicines;
    var response = await _dio.get(
        '${Constants.BASE_URL}/${Constants.API_MEDICINE_ROUTE}?q=$keyword');
    List<dynamic> medicinesResponse = response.data;
    // return mockedMedicines();
    return medicinesResponse.map((m) => Medicine.fromMap(m)).toList();
  }

  static Future<void> addMedicine(Medicine medicine) async {
    var response = await _dio.post(
      '${Constants.BASE_URL}/${Constants.API_MEDICINE_ROUTE}',
      data: medicine.toMap(),
    );
    debugPrint('addMedicine response -> ${response.data}');
  }

  static Future<void> discardMedicines(DiscardMedicineBody body) async {
    // return Future.value();
    var response = await _dio.delete(
      '${Constants.BASE_URL}/${Constants.API_MEDICINE_ROUTE}',
      data: body.toMap(),
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
    if (await GoogleSignIn().isSignedIn()) {
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

var medicines = [
  Medicine(
    id: '1',
    name: 'Teste 1',
    available: 10,
    composition: ['a', 'b'],
    variant: ['100mg', '200mg'],
    expirationDate: DateTime.now().subtract(Duration(days: 10)),
    manufacturer: 'farmacia',
    creationDate: '',
  ),
  Medicine(
    id: '2',
    name: 'Teste 2',
    available: 20,
    composition: ['a', 'b'],
    variant: ['100mg', '200mg'],
    expirationDate: DateTime.now(),
    manufacturer: 'farmacia',
    creationDate: '',
  ),
  Medicine(
    id: '3',
    name: 'Teste 3',
    available: 30,
    composition: ['a', 'b'],
    variant: ['100mg', '200mg'],
    expirationDate: DateTime.now().add(Duration(days: 10)),
    manufacturer: 'farmacia',
    creationDate: '',
  ),
  Medicine(
    id: '4',
    name: 'Teste 4',
    available: 40,
    composition: ['a', 'b'],
    variant: ['100mg', '200mg'],
    expirationDate: DateTime.now().add(Duration(days: 60)),
    manufacturer: 'farmacia',
    creationDate: '',
  ),
];
