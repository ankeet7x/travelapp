import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:travelapp/core/models/postmodel.dart';
import 'package:travelapp/core/services/placeservices.dart';

class PlaceProvider extends ChangeNotifier {
  PlaceServices placeServices = PlaceServices();
  List<PlaceModel> places = [];
  bool isPlaceEmpty = true;
  int selectedIndex = 0;
  updateIndex(index) {
    selectedIndex = index;
    notifyListeners();
  }

  getPlaces() async {
    var response = await placeServices.getPlaces();
    var jsonData = jsonDecode(response.body);
    List<PlaceModel> fetchedPlaces = [];
    jsonData['places'].forEach((place) {
      PlaceModel placeModel = PlaceModel.fromJson(place);
      fetchedPlaces.add(placeModel);
    });
    places = fetchedPlaces;
    isPlaceEmpty = false;
    print('gotit');
    notifyListeners();
  }
}
