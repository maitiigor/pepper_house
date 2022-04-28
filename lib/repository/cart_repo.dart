import 'package:flutter/foundation.dart';
import 'package:pepper_house/models/cart_model.dart';

class CartRepo with ChangeNotifier, DiagnosticableTreeMixin {
  final List<CartModel> _cart = [];

  List<CartModel> addToCart(
      {menuId, name, description, imageUrl, quantity, price, total}) {
    _cart.add(CartModel(
        menuId: menuId,
        name: name,
        description: description,
        imageUrl: imageUrl,
        quantity: quantity,
        price: price,
        total: total));
    notifyListeners();
    return _cart;
  }

  String get countCart => _cart.length.toString();

  List<CartModel> get carts => _cart;

  List<CartModel> removeItemFromCart(index) {
    _cart.removeAt(index);

    notifyListeners();

    return _cart;
  }

  String totalAmount() {
    int total = 0;
    for (var item in _cart) {
      total += int.parse(item.total);
    }
    return total.toString();
  }

  void emptyCart() {
    _cart.clear();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('count', countCart));
  }
}
