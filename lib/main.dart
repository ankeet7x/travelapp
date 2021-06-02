import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelapp/app/shared/helpers.dart';
import 'package:travelapp/core/providers/orderprovider.dart';
import 'package:travelapp/core/providers/placeprovider.dart';
import 'package:travelapp/meta/views/home.dart';
import 'package:travelapp/meta/views/signup.dart';
import 'core/providers/authprovider.dart';

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
