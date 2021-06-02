class OrderModel {
  String id;
  String place;
  String bookedBy;
  String date;
  int price;

  OrderModel(
      {required this.id,
      required this.place,
      required this.bookedBy,
      required this.date,
      required this.price});

  factory OrderModel.fromJson(Map<String, dynamic> order) {
    return OrderModel(
        id: order['_id'],
        place: order['place'],
        bookedBy: order['bookedBy'],
        date: order['date'],
        price: order['price']);
  }
}
