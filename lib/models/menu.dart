import 'package:cloud_firestore/cloud_firestore.dart';

class Menu {
  String? id;
  String name;
  String description;
  String price;
  String imageUrl;
  Timestamp createdAt;
  Timestamp updatedAt;
  Menu(
      {this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.imageUrl,
      required this.createdAt,
      required this.updatedAt});
  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      price: json["price"],
      imageUrl: json["image_url"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
    );
  }
  Map<String, dynamic> toJson() => {
    
        "name": name,
        "description": description,
        "price": price,
        "image_url": imageUrl,
        "created_at": createdAt.toString(),
        "update_at": createdAt.toString()
      };

       Menu.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        name = doc.data()!["name"],
        description = doc.data()!["description"],
        price = doc.data()!["price"],
        imageUrl = doc.data()!["image_url"],
        createdAt = doc.data()!["created_at"],
        updatedAt = doc.data()!["updated_at"];
  }
  
   /*    Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'salary': salary,
      'address': address.toMap(),
      'employeeTraits': employeeTraits
    };
  } */

 /* Menu.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        name = doc.data()!["name"],
        description = doc.data()!["description"],
        price = doc.data()!["price"],
        imageUrl = doc.data()!["image_url"],
        createdAt = doc.data()!["created_at"],
        updatedAt = doc.data()!["updated_at"];
} */

