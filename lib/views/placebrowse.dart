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
              shrinkWrap: true,
              itemCount: placeProvider.places.length,
              itemBuilder: (context, index) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            baseUrl + placeProvider.places[index].placeImageUrl,
                            fit: BoxFit.cover,
                            height: size.height * 0.2,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          placeProvider.places[index].placeName,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Center(
                        child: Text(
                          "Rs." + placeProvider.places[index].price,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]);
              },
            ),
    );
  }
}
