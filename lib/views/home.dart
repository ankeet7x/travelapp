import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:travelapp/helpers/helpers.dart';
import 'package:travelapp/providers/authprovider.dart';
import 'package:travelapp/providers/orderprovider.dart';
import 'package:travelapp/providers/placeprovider.dart';
import 'package:travelapp/views/placebrowse.dart';
import 'package:travelapp/views/signup.dart';

import 'profile.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Helpers helpers = Helpers();
  List _body = [PlaceBrowseView(), ProfileView()];

  getPlaces() async {
    final placeProvider = Provider.of<PlaceProvider>(context, listen: false);
    placeProvider.getPlaces();
  }

  // late String user;
  // getUser() async {
  //   setState(() {
  //     user = Helpers().getUserName().toString();
  //   });
  // }

  @override
  void initState() {
    getPlaces();
    // getUser();
    super.initState();
  }

  _exitTheApp() async {
    SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    final placeProvider = Provider.of<PlaceProvider>(context);
    return WillPopScope(
      onWillPop: () => _exitTheApp(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              ),
              onPressed: () {
                helpers.removeUserData();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignupView()));
              },
            )
          ],
          title: FutureBuilder(
            future: helpers.getUserName(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Text(
                  "Hello " + snapshot.data.toString(),
                  style: TextStyle(color: Colors.black),
                );
              } else {
                return Container();
              }
            },
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: _body.elementAt(placeProvider.selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            placeProvider.updateIndex(index);
          },
          currentIndex: placeProvider.selectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.blue,
          items: [
            BottomNavigationBarItem(
                icon: Icon(placeProvider.selectedIndex == 0
                    ? Icons.home
                    : Icons.home_outlined),
                label: "Place"),
            BottomNavigationBarItem(
                icon: Icon(placeProvider.selectedIndex == 1
                    ? Icons.person
                    : Icons.person_outline),
                label: "Person")
          ],
        ),
      ),
    );
  }
}
