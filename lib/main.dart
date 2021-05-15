import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelapp/providers/authprovider.dart';
import 'package:travelapp/views/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: AuthProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Travel App",
        home: SignupView(),
      ),
    );
  }
}
