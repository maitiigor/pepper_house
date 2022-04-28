import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:pepper_house/controller/user_controller.dart';
import 'package:pepper_house/models/order.dart';

class OrderRepository with ChangeNotifier, DiagnosticableTreeMixin {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  // 2
  List<Order> _orderList = [];

  Future<List<Order>> retrieveOrder() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("orders").get();
    _orderList = snapshot.docs
        .map((docSnapShot) => Order.fromDocumentSnapshot(docSnapShot))
        .toList();

    notifyListeners();
    return _orderList;
  }

  List<Order> get order => _orderList;
  Future<DocumentReference> addOrder(Order order) async {
    DocumentReference doc = await _db.collection("orders").add(order.toJson());

    return doc;
  }

  // 4
  void updateOrder(Order order) async {
    await _db
        .collection("orders")
        .doc(order.id)
        .update(order.toJson())
        .onError((error, stackTrace) => print(error))
        .whenComplete(() => null);
  }

  // 5
  void deleteOrder(Order order) async {
    await _db.collection("orders").doc(order.id).delete();
  }
}
