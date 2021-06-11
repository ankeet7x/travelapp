import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:travelapp/core/models/placemodel.dart';
import 'package:travelapp/core/services/cacheservices.dart';
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

  List<PlaceModel> offPlaces = [];
  getList() async {
    List<PlaceModel> places = await DatabaseService.instance.getPlaces();
    offPlaces = places;
    notifyListeners();
  }

  getPlaces() async {
    var response = await placeServices.getPlaces();
    var jsonData = jsonDecode(response.body);
    List<PlaceModel> fetchedPlaces = [];
    if (jsonData['places'] != null) {
      DatabaseService.instance.delete();
    }
    jsonData['places'].forEach((place) {
      PlaceModel placeModel = PlaceModel.fromJson(place);
      fetchedPlaces.add(placeModel);
      DatabaseService().insertIntoDatabase(placeModel);
    });
    places = fetchedPlaces;
    isPlaceEmpty = false;
    print('gotit');
    notifyListeners();
  }

  late PlaceModel bookedPlace;
  bool placeLoadedById = false;

  getPlaceById(String id) async {
    var response = await placeServices.getPlaceById(id);
    var jsonData = await jsonDecode(response.body);
    if (jsonData['place'] != null) {
      var place = jsonData['place'];
      PlaceModel currentPlace = PlaceModel.fromJson(place);
      bookedPlace = currentPlace;
      placeLoadedById = true;
      notifyListeners();
    }

    placeLoadedById = true;
    notifyListeners();
  }
}
