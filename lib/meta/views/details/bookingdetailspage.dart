import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelapp/core/providers/placeprovider.dart';

class BookingDetailsPage extends StatefulWidget {
  final String orderId;
  final String placeId;
  final String dateOfOrder;
  final int price;

  BookingDetailsPage(
      {required this.orderId,
      required this.placeId,
      required this.dateOfOrder,
      required this.price});

  @override
  _BookingDetailsPageState createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {
  getPlaceById() {
    Provider.of<PlaceProvider>(context, listen: false)
        .getPlaceById(widget.placeId);
  }

  @override
  void initState() {
    super.initState();
    getPlaceById();
  }

  @override
  Widget build(BuildContext context) {
    final placePro = Provider.of<PlaceProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Container(
                child: placePro.placeLoadedById
                    ? buildCoverImage(size)
                    : Container(
                        height: size.height * 0.4,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ))
          ],
        ),
      ),
    );
  }

  Widget buildCoverImage(size) {
    return Container(
        width: size.width,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35)),
          child: Image.network(
            Provider.of<PlaceProvider>(context)
                .bookedPlace
                .placeImageUrl
                .toString()
                .replaceAll('http', 'https'),
            height: size.height * 0.4,
            fit: BoxFit.cover,
          ),
        ));
  }
}
