class PlaceModel {
  String id;
  String placeName;
  String price;
  String placeImageUrl;

  PlaceModel(
      {required this.id,
      required this.placeName,
      required this.placeImageUrl,
      required this.price});

  factory PlaceModel.fromJson(Map<String, dynamic> jsonData) {
    return PlaceModel(
        id: jsonData['_id'],
        placeName: jsonData['placeName'],
        price: jsonData['price'],
        placeImageUrl: jsonData['placeImage']);
  }
}
