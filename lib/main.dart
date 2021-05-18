import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelapp/helpers/helpers.dart';
import 'package:travelapp/providers/authprovider.dart';
import 'package:travelapp/providers/orderprovider.dart';
import 'package:travelapp/providers/placeprovider.dart';
import 'package:travelapp/views/home.dart';
import 'package:travelapp/views/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isUserThere = await Helpers().isUserThere();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: AuthProvider()),
      ChangeNotifierProvider.value(value: PlaceProvider()),
      ChangeNotifierProvider.value(value: OrderProvider())
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Travel App",
      home: isUserThere ? HomeView() : SignupView(),
    ),
  ));
}
