class UserModel {
  final String uid;
  final String email;
  final String shopName;
  final String place;

  UserModel({
    required this.uid,
    required this.email,
    required this.shopName,
    required this.place,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'shopName': shopName,
      'place': place,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      shopName: map['shopName'],
      place: map['place'],
    );
  }
}
