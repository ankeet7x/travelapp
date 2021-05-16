import 'package:http/http.dart' as http;
import 'package:travelapp/constants/urls.dart';

class PlaceServices {
  getPlaces() async {
    var reqUrl = Uri.parse(placeUrl);
    print('getting places');
    var response = await http.get(reqUrl);
    return response;
  }
}
