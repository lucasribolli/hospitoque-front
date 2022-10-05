import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInReposity {
  GoogleSignInReposity._();

  static Future<String?> signIn() async {
    var account = await GoogleSignIn().signIn();
    return account?.email;
  }
}