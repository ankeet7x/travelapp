import 'package:flutter/material.dart';
import 'package:travelapp/helpers/helpers.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
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
      ],
    ));
  }
}
