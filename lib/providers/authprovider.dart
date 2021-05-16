import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:travelapp/helpers/helpers.dart';
import 'package:travelapp/models/usermodel.dart';
import 'package:travelapp/services/authservices.dart';

class AuthProvider extends ChangeNotifier {
  AuthServices authServices = AuthServices();
  Helpers helpers = Helpers();
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

  late UserModel currentUser;
  loginUser(username, password) async {
    loading = true;
    notifyListeners();
    var response = await authServices.loginUser(username, password);
    var jsonData = await jsonDecode(response.body);

    if (jsonData['message'] == 'userLoggedIn') {
      UserModel userModel = UserModel.fromJson(jsonData['userData']);
      helpers.saveFirstName(userModel.firstName);
      helpers.saveLastName(userModel.lastName);
      helpers.saveId(userModel.id);
      helpers.savePhoneNumber(userModel.phoneNumber.toString());
      helpers.saveUserName(username);
      helpers.saveToken(jsonData['token']);
    }
    loading = false;
    notifyListeners();
    return jsonData['message'];
  }
}
