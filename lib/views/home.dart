import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelapp/providers/placeprovider.dart';
import 'package:travelapp/views/placebrowse.dart';

class HomeView extends StatefulWidget {
  final String userName;
  HomeView({required this.userName});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List _body = [PlaceBrowseView(), Text("Swop")];

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

  @override
  Widget build(BuildContext context) {
    final placeProvider = Provider.of<PlaceProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hello " + widget.userName,
          style: TextStyle(color: Colors.black),
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
        unselectedItemColor: Colors.yellow,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Place"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Person")
        ],
      ),
    );
  }
}

// placeProvider.isPlaceEmpty
//           ? CircularProgressIndicator()
//           : ListView.builder(
//               itemCount: placeProvider.places.length,
//               itemBuilder: (context, index) =>
//                   Text(placeProvider.places[index].placeName),
//             ),
