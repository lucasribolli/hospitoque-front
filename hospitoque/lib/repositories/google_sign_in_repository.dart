import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInRepository {
  GoogleSignInRepository._();

  static Future<String?> signIn() async {
    var account = await GoogleSignIn().signIn();
    return account?.email;
  }

  static Future<void> logout() async {
    await GoogleSignIn().signOut();
  }
}