import 'package:http/http.dart' as http;
import 'package:travelapp/app/constants/urls.dart';

class AuthServices {
  createUser(username, firstname, lastname, password, phoneNo) async {
    var reqUrl = Uri.parse(signUpUrl);
    print("signing up");
    Map<String, dynamic> userData = {
      "firstName": firstname,
      "lastName": lastname,
      "userName": username,
      "password": password,
      "phoneNumber": phoneNo
    };
    var response = await http.post(reqUrl, body: userData);
    return response;
  }

  loginUser(username, password) async {
    var reqUrl = Uri.parse(loginUrl);
    print("logging in");
    Map<String, dynamic> userCredentials = {
      "username": username,
      "password": password
    };
    var response = await http.post(reqUrl, body: userCredentials);
    return response;
  }
}
