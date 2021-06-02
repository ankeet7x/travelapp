import 'package:http/http.dart' as http;
import 'package:travelapp/app/constants/urls.dart';
import 'package:travelapp/app/shared/helpers.dart';

class OrderServices {
  Helpers helpers = Helpers();
  makeOrder(place, bookedBy, date, price) async {
    var reqUrl = Uri.parse(bookingUrl);
    String jwtKey = "Bearer " + helpers.getUserToken().toString();
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

  // Helpers helpers = Helpers();

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

  deleteSpecificBooking(bookingId) async {
    String token = await helpers.getUserToken();
    var reqUrl = Uri.parse(bookingUrl + bookingId);
    String jwtKey = "Bearer " + token;
    var headers = {"Authorization": jwtKey};
    print("deleting");
    var response = await http.delete(reqUrl, headers: headers);
    return response;
  }
}
