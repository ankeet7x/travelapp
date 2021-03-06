import 'package:shared_preferences/shared_preferences.dart';

class Helpers {
  saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentUserToken', token);
  }

  getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('currentUserToken').toString();
  }

  Future<bool> isUserThere() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('currentUserToken') != null) {
      return true;
    } else {
      return false;
    }
  }

  saveId(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', id);
  }

  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid').toString();
  }

  saveUserName(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', userName);
  }

  getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName');
  }

  saveFirstName(String firstName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName', firstName);
  }

  getFirstName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('firstName');
  }

  saveLastName(String lastName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastName', lastName);
  }

  getLastName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('lastName');
  }

  savePhoneNumber(String phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('phoneNumber', phoneNumber);
  }

  getPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('phoneNumber');
  }

  removeUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('currentUserToken');
    prefs.remove('uid');
    prefs.remove('userName');
    prefs.remove('firstName');
    prefs.remove('lastName');
    prefs.remove('phoneNumber');
  }
}
