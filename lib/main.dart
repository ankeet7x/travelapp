import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelapp/helpers/helpers.dart';
import 'package:travelapp/providers/authprovider.dart';
import 'package:travelapp/views/home.dart';
import 'package:travelapp/views/login.dart';
import 'package:travelapp/views/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isUserThere = await Helpers().isUserThere();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider.value(value: AuthProvider())],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Travel App",
      home: LoginView(),
    ),
  ));
}
