/* import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:pepper_house/models/order_detail.dart';

class OrderDetailRepository with ChangeNotifier, DiagnosticableTreeMixin {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  // 2
  final CollectionReference<Map<String, dynamic>> _orderCollections =
      FirebaseFirestore.instance.collection("order_details");
  List<OrderDetail> _orderDetailList = [];

  Future<List<OrderDetail>> retrieveOrderdetailDetail() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _orderCollections.get();
    _orderDetailList = snapshot.docs
        .map((docSnapShot) => OrderDetail.fromDocumentSnapshot(docSnapShot))
        .toList();
    notifyListeners();
    return _orderDetailList;
  }

  Future<DocumentReference> addOrderdetailDetail(OrderDetail orderdetail) {
    return _orderCollections.add(orderdetail.toJson());
  }

  // 4
  void updateOrderdetail(OrderDetail orderdetail) async {

    await _orderCollections
        .doc(orderdetail.id)
        .update(orderdetail.toJson());
  }

  // 5
  void deleteOrderdetail(OrderDetail orderdetail) async {

    await _orderCollections.doc(orderdetail.id).delete();
  }
}
 */