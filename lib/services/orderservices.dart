import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelapp/constants/urls.dart';

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
}
