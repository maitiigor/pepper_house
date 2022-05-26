import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class MenuCategory {
  String id;
  String categoryName;
  MenuCategory({required this.id, required this.categoryName});

   factory MenuCategory.fromJson(Map<String, dynamic> json) {
    return MenuCategory(
      id: json["id"],
      categoryName: json["category_name"]
    );
  }
  Map<String, dynamic> toJson() => {
    
        "category_name": categoryName
      };

       MenuCategory.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        categoryName = doc.data()!["category_name"];
  }
