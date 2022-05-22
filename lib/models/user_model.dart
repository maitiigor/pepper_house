import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String? email;
  String? displayName;
  String? photoURL;
  String? address;
  String? phoneNumber;
  Timestamp? createdAt;
  Timestamp? updatedAt;

  UserModel({required this.uid, this.email, this.displayName, this.photoURL, this.address, this.phoneNumber, this.createdAt, this.updatedAt});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json["id"],
      email: json["email"],
      displayName: json["full_name"],
      address: json["address"],
      phoneNumber: json["phone_number"],
      createdAt: json["created_at"],
      updatedAt: json["update_at"]
    );

  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "full_name": displayName,
        "address": address,
        "phone_number": phoneNumber,
        "created_at": createdAt!.toDate(),
        "updated_at": updatedAt!.toDate(),
      };

  UserModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : uid = doc.id,
        email = doc.data()!["email"],
        displayName = doc.data()!["full_name"],
        address = doc.data()!["address"],
        phoneNumber = doc.data()!["phone_number"],
        createdAt = doc.data()!['created_at'],
        updatedAt = doc.data()!['updated_at'];
}



