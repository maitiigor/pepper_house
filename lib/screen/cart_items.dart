import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pepper_house/repository/cart_repo.dart';
import 'package:pepper_house/screen/check_out.dart';
import 'package:provider/provider.dart';

class CartItemsPage extends StatefulWidget {
  const CartItemsPage({Key? key}) : super(key: key);

  @override
  State<CartItemsPage> createState() => _CartItemsPageState();
}

class _CartItemsPageState extends State<CartItemsPage> {
  final _cart = CartRepo();
  int _cartCount = 0;
  double _heightConstraint = 0;

  void _computeHeight() {
    _cartCount = int.parse(_cart.countCart);
    if (_cartCount > 0 && _cartCount <= 3) {
      _heightConstraint = 0.4;
    }
    if (_cartCount > 3 && _cartCount <= 5) {
      _heightConstraint = 0.7;
    }
    if (_cartCount > 5) {
      _heightConstraint = 1;
    }
  }

  @override
  void initState() {
    _computeHeight();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView.builder(
                    itemCount: int.parse(context.watch<CartRepo>().countCart),
                    itemBuilder: (context, index) {
                      if (context.watch<CartRepo>().carts.length == index + 1) {
                        return GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                elevation: 5,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: SizedBox(
                                              height: 100,
                                              width: 150,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8, left: 8, right: 8),
                                                child: CachedNetworkImage(
                                                    fit: BoxFit.cover,
                                                    progressIndicatorBuilder:
                                                        (context, url,
                                                            progress) {
                                                      return const Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: SizedBox(
                                                              height: 30,
                                                              width: 30,
                                                              child:
                                                                  CircularProgressIndicator()));
                                                    },
                                                    imageUrl: context
                                                        .watch<CartRepo>()
                                                        .carts[index]
                                                        .imageUrl),
                                              )),
                                        ),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 25,
                                                        vertical: 3),
                                                child: Text(
                                                  context
                                                      .watch<CartRepo>()
                                                      .carts[index]
                                                      .name,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ))),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 25,
                                          ),
                                          child: Text(context
                                                  .watch<CartRepo>()
                                                  .carts[index]
                                                  .price +
                                              " x " +
                                              context
                                                  .watch<CartRepo>()
                                                  .carts[index]
                                                  .quantity +
                                              " = " +
                                              context
                                                  .watch<CartRepo>()
                                                  .carts[index]
                                                  .total),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: TextButton(
                                              child: const Text('Remove item'),
                                              onPressed: () {
                                                context
                                                    .read<CartRepo>()
                                                    .removeItemFromCart(index);
                                                _computeHeight();
                                                setState(() {});
                                              }),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                  "Total amount: " +
                                      context.watch<CartRepo>().totalAmount(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const CheckOutPage()));
                                    },
                                    style: TextButton.styleFrom(
                                        elevation: 5,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0)),
                                        ),
                                        backgroundColor: Colors.red),
                                    child: const Text(
                                      "Proceed to payment",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )),
                              ),
                              const SizedBox(
                                height: 40,
                              )
                            ],
                          ),
                        );
                      } else {
                        return GestureDetector(
                          onTap: () {},
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            elevation: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: SizedBox(
                                              height: 100,
                                              width: 150,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8, left: 8, right: 8),
                                                child: CachedNetworkImage(
                                                    fit: BoxFit.cover,
                                                    progressIndicatorBuilder:
                                                        (context, url,
                                                            progress) {
                                                      return const Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: SizedBox(
                                                              height: 30,
                                                              width: 30,
                                                              child:
                                                                  CircularProgressIndicator()));
                                                    },
                                                    imageUrl: context
                                                        .watch<CartRepo>()
                                                        .carts[index]
                                                        .imageUrl),
                                              )),
                                        ),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 25,
                                                        vertical: 3),
                                                child: Text(
                                                  context
                                                      .watch<CartRepo>()
                                                      .carts[index]
                                                      .name,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ))),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 25,
                                          ),
                                          child: Text(context
                                                  .watch<CartRepo>()
                                                  .carts[index]
                                                  .price +
                                              " x " +
                                              context
                                                  .watch<CartRepo>()
                                                  .carts[index]
                                                  .quantity +
                                              " = " +
                                              context
                                                  .watch<CartRepo>()
                                                  .carts[index]
                                                  .total),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: TextButton(
                                              child: const Text('Remove item'),
                                              onPressed: () {
                                                context
                                                    .read<CartRepo>()
                                                    .removeItemFromCart(index);
                                                _computeHeight();
                                                setState(() {});
                                              }),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
