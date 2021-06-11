import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelapp/app/constants/colors.dart';
import 'package:travelapp/app/shared/helpers.dart';
import 'package:travelapp/core/providers/orderprovider.dart';

import '../details/bookingdetailspage.dart';

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
        SizedBox(
          height: 10,
        ),
        Center(
            child: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: AppColor.mainTextColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(
            Icons.person,
            color: Colors.white,
            size: 45,
          ),
        )),
        SizedBox(
          height: 7,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<dynamic>(
                future: Helpers().getFirstName(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Text(
                      snapshot.data.toString() + " ",
                      style: TextStyle(
                          color: AppColor.mainTextColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 22),
                    );
                  } else {
                    return Container();
                  }
                }),
            FutureBuilder<dynamic>(
                future: Helpers().getLastName(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Text(
                      snapshot.data.toString(),
                      style: TextStyle(
                          color: AppColor.mainTextColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 22),
                    );
                  } else {
                    return Container();
                  }
                }),
          ],
        ),
        FutureBuilder<dynamic>(
            future: Helpers().getUserName(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Text(
                  "@" + snapshot.data.toString(),
                  style: TextStyle(
                      color: AppColor.mainTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                );
              } else {
                return Container();
              }
            }),
        SizedBox(
          height: 4,
        ),
        FutureBuilder<dynamic>(
            future: Helpers().getPhoneNumber(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.call, color: AppColor.mainTextColor, size: 20),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      snapshot.data.toString(),
                      style: TextStyle(
                          color: AppColor.mainTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                  ],
                );
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
                                  builder: (context) => BookingDetailsPage(
                                        orderId: bookingPro.bookings[index].id,
                                        placeId:
                                            bookingPro.bookings[index].place,
                                        dateOfOrder:
                                            bookingPro.bookings[index].date,
                                        price: bookingPro.bookings[index].price,
                                      ))),
                          trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => bookingPro.deleteUserBooking(
                                  bookingPro.bookings[index].id)),
                          title: Text("Booking id:" +
                              bookingPro.bookings[index].id.toString()));
                    },
                  ),
          );
        })
      ],
    ));
  }
}
