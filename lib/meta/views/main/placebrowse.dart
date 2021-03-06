import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelapp/app/constants/colors.dart';
import 'package:travelapp/core/providers/placeprovider.dart';

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
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: placeProvider.offPlaces.length,
              itemBuilder: (context, index) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, '/placedata',
                              arguments: index),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Hero(
                              tag: 'img' + index.toString(),
                              child: Image.network(
                                placeProvider.offPlaces[index].placeImageUrl
                                    .replaceAll("http", "https"),
                                fit: BoxFit.cover,
                                height: size.height * 0.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          placeProvider.offPlaces[index].placeName,
                          style: TextStyle(
                              color: AppColor.mainTextColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Center(
                        child: Text(
                          "Rs." + placeProvider.offPlaces[index].price,
                          style: TextStyle(
                              fontSize: 20, color: AppColor.mainTextColor),
                        ),
                      ),
                    ]);
              },
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
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, '/placedata',
                              arguments: index),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Hero(
                              tag: 'img' + index.toString(),
                              child: Image.network(
                                placeProvider.places[index].placeImageUrl
                                    .replaceAll("http", "https"),
                                fit: BoxFit.cover,
                                height: size.height * 0.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          placeProvider.places[index].placeName,
                          style: TextStyle(
                              color: AppColor.mainTextColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Center(
                        child: Text(
                          "Rs." + placeProvider.places[index].price,
                          style: TextStyle(
                              fontSize: 20, color: AppColor.mainTextColor),
                        ),
                      ),
                    ]);
              },
            ),
    );
  }
}
