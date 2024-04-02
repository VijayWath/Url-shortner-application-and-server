import 'package:shared_preferences/shared_preferences.dart';

class TokenRepository {
  Future<void> setToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('x-auth-token', token);
  }

  Future<String?> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('x-auth-token');
    return token;
  }

  void clearToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('x-auth-token');
  }
}
