class CartModel {
  String menuId;
  String name;
  String description;
  String imageUrl;
  String quantity;
  String price;
  String total;
  CartModel(
      {required this.menuId,
      required this.name,
      required this.description,
      required this.imageUrl,
      required this.quantity,
      required this.price,
      required this.total});
}
