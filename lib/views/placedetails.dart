import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelapp/constants/urls.dart';
import 'package:travelapp/providers/placeprovider.dart';

class PlaceDetails extends StatefulWidget {
  final placeIndex;
  PlaceDetails({required this.placeIndex});

  @override
  _PlaceDetailsState createState() => _PlaceDetailsState();
}

class _PlaceDetailsState extends State<PlaceDetails> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final placeProvider = Provider.of<PlaceProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35)),
                child: Hero(
                  tag: "img" + widget.placeIndex.toString(),
                  child: Image.network(
                    baseUrl +
                        placeProvider.places[widget.placeIndex].placeImageUrl,
                    height: size.height * 0.4,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  placeProvider.places[widget.placeIndex].placeName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(28.0, 0, 28.0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "For a few days, You'll be travelling with us to this beautiful place. Pack your bags and be ready to go for yet another adventure with us.",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () => {print("lol")},
              child: Container(
                width: size.width * 0.7,
                height: size.height * 0.07,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue),
                child: Center(
                    child: Text("Book",
                        style: TextStyle(color: Colors.white, fontSize: 19))),
              ),
            )),
      ),
    );
  }
}
