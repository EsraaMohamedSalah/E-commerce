// In auth_service.dart
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> loginUser(String email, String password) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      // Save login state in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);
    } else {
      throw Exception('Invalid login credentials');
    }
  }
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
  }
}
