import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelapp/providers/orderprovider.dart';
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
                    placeProvider.places[widget.placeIndex].placeImageUrl
                        .replaceAll('http', 'https'),
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
              onTap: () async {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Booking"),
                  duration: Duration(seconds: 1),
                ));
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String userId = prefs.getString('uid')!;
                final bookProvider =
                    Provider.of<OrderProvider>(context, listen: false);
                var response = await bookProvider.postOrder(
                    placeProvider.places[widget.placeIndex].id,
                    userId,
                    DateTime.now().toIso8601String(),
                    placeProvider.places[widget.placeIndex].price);

                if (response == 'booked') {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Booked")));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Already Booked"),
                    duration: Duration(seconds: 2),
                  ));
                }
              },
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
