import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:pepper_house/models/menu.dart';
import 'package:pepper_house/models/menu_category_model.dart';

class MenuCategoryRepository with ChangeNotifier, DiagnosticableTreeMixin {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  // 2
  List<MenuCategory> _menuCategoryList = [];

  Future<List<MenuCategory>> retieveMenuCategory() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("menu_categories").get();
    notifyListeners();

    _menuCategoryList = snapshot.docs
        .map((docSnapShot) => MenuCategory.fromDocumentSnapshot(docSnapShot))
        .toList();
    return _menuCategoryList;
  }

  List<MenuCategory> get menuCategoryList => _menuCategoryList;

  Future<DocumentReference> addMenuCategories(MenuCategory category) {
    return _db.collection("menus").add(category.toJson());
  }

  // 4
  void updateMenu(MenuCategory category) async {
    await _db.collection("menus").doc(category.id).update(category.toJson());
  }

  // 5
  void deleteMenu(Menu menu) async {
    await _db.collection("menus").doc(menu.id).delete();
  }
}
