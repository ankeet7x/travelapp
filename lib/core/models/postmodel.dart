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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'place': placeName,
      'price': price,
      'placeImageUrl': placeImageUrl
    };
  }

  factory PlaceModel.fromMap(Map<String, dynamic> jsonData) {
    return PlaceModel(
        id: jsonData['id'],
        placeName: jsonData['place'],
        price: jsonData['price'],
        placeImageUrl: jsonData['placeImageUrl']);
  }
}
