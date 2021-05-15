import 'package:travelapp/constants/urls.dart';
import 'package:http/http.dart' as http;

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
}
