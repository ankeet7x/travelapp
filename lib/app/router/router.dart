import 'package:flutter/material.dart';
import 'package:travelapp/meta/views/auth/login.dart';
import 'package:travelapp/meta/views/auth/signup.dart';
import 'package:travelapp/meta/views/details/placedetails.dart';
import 'package:travelapp/meta/views/home.dart';
import 'package:travelapp/meta/views/main/profile.dart';

class RouteGenerator {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginView());
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignupView());
      case '/placedata':
        if (settings.arguments is int) {
          return MaterialPageRoute(
              builder: (_) => PlaceDetails(placeIndex: settings.arguments));
        } else {
          return MaterialPageRoute(builder: (_) => HomeView());
        }
      // case '/bookingdetails':
      //   final bookingArguments = args;
      //   return MaterialPageRoute(builder: (context) => BookingDetailsPage(orderId: , placeId: placeId, dateOfOrder: dateOfOrder))
      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfileView());
      default:
        return MaterialPageRoute(builder: (_) => LoginView());
    }
  }
}
