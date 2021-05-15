import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:travelapp/services/authservices.dart';

class AuthProvider extends ChangeNotifier {
  AuthServices authServices = AuthServices();

  bool obscureText = true;
  bool loading = false;

  changeBool() {
    obscureText = !obscureText;
    notifyListeners();
  }

  signUpUser(username, firstname, lastname, password, phoneNo) async {
    loading = true;
    notifyListeners();
    var response = await authServices.createUser(
        username, firstname, lastname, password, phoneNo);
    var jsonData = await jsonDecode(response.body);
    loading = false;
    notifyListeners();
    return jsonData['message'];
  }

  loginUser(username, password) async {
    loading = true;
    notifyListeners();
    var response = await authServices.loginUser(username, password);
    var jsonData = await jsonDecode(response.body);
    loading = true;
    notifyListeners();
    return jsonData['message'];
  }
}
