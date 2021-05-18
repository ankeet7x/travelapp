import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelapp/helpers/helpers.dart';
import 'package:travelapp/providers/orderprovider.dart';

import 'bookingdetailspage.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    fetchBookings();
  }

  fetchBookings() async {
    final bookingProvider = Provider.of<OrderProvider>(context, listen: false);
    await bookingProvider.getBookingOfThisUser();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Center(
            child: Icon(
          Icons.person,
          size: 35,
        )),
        FutureBuilder<dynamic>(
            future: Helpers().getUserName(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Text(snapshot.data.toString());
              } else {
                return Container();
              }
            }),
        FutureBuilder<dynamic>(
            future: Helpers().getFirstName(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Text(snapshot.data.toString());
              } else {
                return Container();
              }
            }),
        FutureBuilder<dynamic>(
            future: Helpers().getLastName(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Text(snapshot.data.toString());
              } else {
                return Container();
              }
            }),
        FutureBuilder<dynamic>(
            future: Helpers().getPhoneNumber(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Text(snapshot.data.toString());
              } else {
                return Container();
              }
            }),
        Consumer<OrderProvider>(builder: (context, bookingPro, child) {
          return Container(
            child: !bookingPro.gotOrders
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: bookingPro.bookings.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookingDetailsPage())),
                          trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => bookingPro.deleteUserBooking(
                                  bookingPro.bookings[index].id)),
                          title: Text("Booking " + (index + 1).toString()));
                    },
                  ),
          );
        })
      ],
    ));
  }
}
