class UserModel {
  String id;
  String firstName;
  String lastName;
  dynamic phoneNumber;

  UserModel(
      {required this.firstName,
      required this.lastName,
      required this.id,
      required this.phoneNumber});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['_id'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        phoneNumber: json['phoneNumber'] as dynamic);
  }
}
