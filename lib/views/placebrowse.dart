import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelapp/constants/urls.dart';
import 'package:travelapp/providers/placeprovider.dart';

class PlaceBrowseView extends StatefulWidget {
  @override
  _PlaceBrowseViewState createState() => _PlaceBrowseViewState();
}

class _PlaceBrowseViewState extends State<PlaceBrowseView> {
  @override
  Widget build(BuildContext context) {
    final placeProvider = Provider.of<PlaceProvider>(context);
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      color: Colors.white,
      child: placeProvider.isPlaceEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: placeProvider.places.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Text(placeProvider.places[index].placeName),
                  ],
                );
              },
            ),
    );
  }
}
