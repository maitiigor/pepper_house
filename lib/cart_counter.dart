import 'package:flutter/widgets.dart';

class CartCounter extends InheritedWidget {
  const CartCounter({
    Key? key,
    required this.count,
    required Widget child,
  }) : super(key: key, child: child);

  final String count;

  static CartCounter of(BuildContext context) {
    final CartCounter? result = context.dependOnInheritedWidgetOfExactType<CartCounter>();
    assert(result != null, 'No CartCounter found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(CartCounter old) => true;
}

