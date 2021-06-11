import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelapp/app/constants/colors.dart';
import 'package:travelapp/core/providers/orderprovider.dart';
import 'package:travelapp/core/providers/placeprovider.dart';

class PlaceDetails extends StatefulWidget {
  final placeIndex;
  PlaceDetails({required this.placeIndex});

  @override
  _PlaceDetailsState createState() => _PlaceDetailsState();
}

class _PlaceDetailsState extends State<PlaceDetails> {
  bool isApiCallProgress = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final placeProvider = Provider.of<PlaceProvider>(context);
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<OrderProvider>(context).isApiCallProgress,
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
              padding: const EdgeInsets.only(left: 28.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Rs. " + placeProvider.places[widget.placeIndex].price,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
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
                final bookProvider =
                    Provider.of<OrderProvider>(context, listen: false);

                SharedPreferences prefs = await SharedPreferences.getInstance();
                String userId = prefs.getString('uid')!;
                print(userId.toString());

                var response = await bookProvider.postOrder(
                    placeProvider.places[widget.placeIndex].id,
                    userId,
                    DateTime.now().toIso8601String(),
                    placeProvider.places[widget.placeIndex].price);
                if (response == 'booked') {
                  displayDialog("Booked");
                } else if (response == 'already booked') {
                  displayDialog("Already Booked");
                }
              },
              child: Container(
                width: size.width * 0.7,
                height: size.height * 0.07,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.mainTextColor),
                child: Center(
                    child: Text("Book",
                        style: TextStyle(color: Colors.white, fontSize: 19))),
              ),
            )),
      ),
    );
  }

  Future<dynamic> displayDialog(String status) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    status,
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
                  ),
                  TextButton(
                      onPressed: () =>
                          Navigator.of(context, rootNavigator: true).pop(),
                      child: Text(
                        "Ok",
                        style: TextStyle(fontSize: 20),
                      ))
                ],
              ),
            ));
  }
}
