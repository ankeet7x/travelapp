import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelapp/constants/urls.dart';
import 'package:travelapp/helpers/helpers.dart';

class OrderServices {
  makeOrder(place, bookedBy, date, price) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var reqUrl = Uri.parse(bookingUrl);
    String token = prefs.getString('currentUserToken')!;
    String jwtKey = "Bearer " + token;
    print(jwtKey);
    var headers = {"Authorization": jwtKey};
    print("booking");
    Map<String, dynamic> bookingModel = {
      'place': place,
      'bookedBy': bookedBy,
      'date': date,
      'price': price
    };
    var response =
        await http.post(reqUrl, body: bookingModel, headers: headers);
    return response;
  }

  Helpers helpers = Helpers();

  getBookingOfSpecificUser() async {
    String userId = await helpers.getUserId();
    String token = await helpers.getUserToken();
    var reqUrl = Uri.parse(bookingUrl + userId);
    String jwtKey = "Bearer " + token;
    var headers = {"Authorization": jwtKey};
    print('getting');
    var response = await http.get(reqUrl, headers: headers);
    return response;
  }
}
