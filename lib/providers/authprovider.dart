import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:travelapp/services/authservices.dart';

class AuthProvider extends ChangeNotifier {
  AuthServices authServices = AuthServices();

  bool obscureText = true;
  bool loading = false;
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

  changeBool() {
    obscureText = !obscureText;
    notifyListeners();
  }
}
