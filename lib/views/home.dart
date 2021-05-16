import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelapp/providers/placeprovider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  getPlaces() async {
    final placeProvider = Provider.of<PlaceProvider>(context, listen: false);
    placeProvider.getPlaces();
  }

  @override
  void initState() {
    getPlaces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final placeProvider = Provider.of<PlaceProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: placeProvider.isPlaceEmpty
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: placeProvider.places.length,
              itemBuilder: (context, index) =>
                  Text(placeProvider.places[index].placeName),
            ),
    );
  }
}
