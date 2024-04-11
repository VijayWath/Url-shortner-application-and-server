import 'dart:convert';

import 'package:url_shortner_service/models/responseModel.dart';
import 'package:http/http.dart' as http;
import 'package:url_shortner_service/models/userModel.dart';
import 'package:url_shortner_service/respositories/tokenRepository.dart';

class UserRepository {
  final host = 'http://192.168.29.220:3000';
  Future<ResponseModel> userLogin(
    email,
    password,
  ) async {
    try {
      var _response = await http.post(
        Uri.parse(
          "$host/user/login",
        ),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(
          {'email': email, 'password': password},
        ),
      );

      if (_response.statusCode == 404) {
        String error = jsonDecode(_response.body)['error'];
        return ResponseModel(data: null, error: error);
      }

      if (_response.statusCode == 500) {
        String error = jsonDecode(_response.body)['error'];
        return ResponseModel(data: null, error: error);
      }

      if (_response.statusCode == 200) {
        final user = jsonDecode(_response.body)['user'];
        final token = jsonDecode(_response.body)['token'];

        final currUser = UserModel(
          name: user["name"].toString(),
          email: user["email"].toString(),
          uid: user["_id"].toString(),
        );

        await TokenRepository().setToken(token.toString());

        return ResponseModel(data: currUser, error: null);
      }
      return ResponseModel(
          data: null, error: "Something went Wrong while login");
    } catch (e) {
      print("ERROR::" + e.toString());
      return ResponseModel(
          data: null, error: "Something went Wrong while login");
    }
  }

  Future<ResponseModel> userCreateAccount(
      String email, String password, String name) async {
    print("$email-----$name------------$password");
    final body = jsonEncode({
      'email': email.toString(),
      'password': password.toString(),
      'name': name.toString()
    });
    try {
      print("getting response");
      var _response = await http.post(
        Uri.parse("$host/user/signup"),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: body,
      );
      print("got response");
      if (_response.statusCode == 200) {
        final user = jsonDecode(_response.body)['user'];
        final token = jsonDecode(_response.body)['token'];

        final currUser = UserModel(
          name: user["name"].toString(),
          email: user["email"].toString(),
          uid: user["_id"].toString(),
        );

        await TokenRepository().setToken(token.toString());
        return ResponseModel(data: currUser, error: null);
      } else {
        String error = jsonDecode(_response.body)['error'];
        return ResponseModel(data: null, error: error);
      }
    } catch (e) {
      print("ERROR::" + e.toString());
      return ResponseModel(data: null, error: "Something went Wrong sign up");
    }
  }
}
