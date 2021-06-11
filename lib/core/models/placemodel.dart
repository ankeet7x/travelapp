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

  Map<String, dynamic> toMap() {
    return {
      'placeId': id,
      'place': placeName,
      'price': price,
      'placeImageUrl': placeImageUrl
    };
  }

  factory PlaceModel.fromMap(Map<String, dynamic> jsonData) {
    return PlaceModel(
        id: jsonData['placeId'],
        placeName: jsonData['place'],
        price: jsonData['price'],
        placeImageUrl: jsonData['placeImageUrl']);
  }

  PlaceModel copy({
    String? id,
    String? placeName,
    String? price,
    String? placeImageUrl,
  }) =>
      PlaceModel(
          id: id ?? this.id,
          placeName: placeName ?? this.placeName,
          price: price ?? this.price,
          placeImageUrl: placeImageUrl ?? this.placeImageUrl);
}
