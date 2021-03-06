import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelapp/app/router/router.dart';
import 'package:travelapp/app/shared/helpers.dart';
import 'package:travelapp/core/providers/orderprovider.dart';
import 'package:travelapp/core/providers/placeprovider.dart';
import 'core/providers/authprovider.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
      initialRoute: isUserThere ? '/' : '/login',
      onGenerateRoute: RouteGenerator.generateRoutes,
    ),
  ));
}
