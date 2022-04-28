import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pepper_house/models/order_detail.dart';

class Order {
  late String id;
  String userId;
  String paymentReference;
  String totalAmount;
  bool isFufilled;
  List<OrderDetail> orderDetail;
  Timestamp createdAt;
  Timestamp updatedAt;

  Order(
      {required this.id,
      required this.userId,
      required this.paymentReference,
      required this.totalAmount,
      required this.isFufilled,
      required this.orderDetail,
      required this.createdAt,
      required this.updatedAt});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json["id"],
      userId: json["user_id"],
      paymentReference: json["payment_reference"],
      orderDetail: List<OrderDetail>.from(
          json["order_details"].map((x) => OrderDetail.fromJson(x))),
      totalAmount: json["price"],
      isFufilled: json["is_fufilled"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "payment_reference": paymentReference,
        "order_details": List<dynamic>.from(orderDetail.map((x) => x.toJson())),
        "total_amount": totalAmount,
        "is_fufilled": isFufilled,
        "created_at": createdAt.toDate(),
        "updated_at": updatedAt.toDate()
      };

  Order.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        userId = doc.data()!["user_id"],
        paymentReference = doc.data()!["payment_reference"],
        orderDetail = List<OrderDetail>.from(
            doc.data()!['order_details'].map((x) => OrderDetail.fromJson(x))),
        totalAmount = doc.data()!["total_amount"],
        isFufilled = doc.data()!["is_fufilled"],
        createdAt = doc.data()!['created_at'],
        updatedAt = doc.data()!['updated_at'];
}
