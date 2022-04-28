import 'package:cloud_firestore/cloud_firestore.dart';

class OrderDetail {
  String menuId;
  String menuName;
  String price;
  String quantity;
  String totalAmount;

  OrderDetail(
      {required this.menuId,
      required this.menuName,
      required this.price,
      required this.quantity,
      required this.totalAmount});

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      menuId: json["menu_id"],
      menuName: json["menu_name"],
      price: json["price"],
      quantity: json["quantity"],
      totalAmount: json["total_amount"],
    );
  }

  Map<String, dynamic> toJson() => {
        "menu_id": menuId,
        "menu_name": menuName,
        "price": price,
        "quantity": quantity,
        "total_amount": totalAmount,
      };

  OrderDetail.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : menuId = doc.data()!["menu_id"],
        menuName = doc.data()!["menu_name"],
        price = doc.data()!["price"],
        quantity = doc.data()!["quantity"],
        totalAmount = doc.data()!["total_amount"];
}
