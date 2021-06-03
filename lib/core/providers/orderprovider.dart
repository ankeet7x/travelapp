import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:travelapp/core/models/ordermodel.dart';
import 'package:travelapp/core/services/orderservices.dart';

enum BookingStatus { Booking, Completion, Idle }

class OrderProvider extends ChangeNotifier {
  OrderServices orderServices = OrderServices();
  BookingStatus bookingStatus = BookingStatus.Idle;
  bool isApiCallProgress = false;
  postOrder(place, bookedBy, date, price) async {
    isApiCallProgress = true;
    notifyListeners();
    var response = await orderServices.makeOrder(place, bookedBy, date, price);
    var jsonData = await jsonDecode(response.body);
    if (jsonData['message'] != null) {
      isApiCallProgress = false;
      notifyListeners();
    }
    return jsonData['message'];
  }

  List<OrderModel> bookings = [];
  bool gotOrders = false;
  getBookingOfThisUser() async {
    var response = await orderServices.getBookingOfSpecificUser();
    var jsonData = await jsonDecode(response.body);
    List<OrderModel> orders = [];
    jsonData['details'].forEach((booking) {
      OrderModel orderModel = OrderModel.fromJson(booking);
      orders.add(orderModel);
    });
    bookings = orders;
    gotOrders = true;
    notifyListeners();
  }

  deleteUserBooking(id) async {
    await orderServices.deleteSpecificBooking(id);
    // var jsonData = await jsonDecode(response.body);
    getBookingOfThisUser();
    // print(jsonData);
  }

  changeBookingStatus(BookingStatus status) {
    bookingStatus = status;
    notifyListeners();
  }
}
