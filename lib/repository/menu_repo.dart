import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pepper_house/models/menu.dart';

class MenuRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  // 2
  Future<List<Menu>> retrieveMenu() async {
  
      
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("menus").get();
    return snapshot.docs.map((docSnapShot) => Menu.fromDocumentSnapshot(docSnapShot)).toList();
  }

  Future<DocumentReference> addMenu(Menu menu) {
    return _db.collection("menus").add(menu.toJson());
  }

  // 4
  void updateMenu(Menu menu) async {
    await _db.collection("menus").doc(menu.id).update(menu.toJson());
  }

  // 5
  void deleteMenu(Menu menu) async {
    await _db.collection("menus").doc(menu.id).delete();
  }
}
