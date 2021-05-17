import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:travelapp/services/orderservices.dart';

class OrderProvider extends ChangeNotifier {
  OrderServices orderServices = OrderServices();

  postOrder(place, bookedBy, date, price) async {
    var response = await orderServices.makeOrder(place, bookedBy, date, price);
    var jsonData = await jsonDecode(response.body);
    print(jsonData);
  }
}
