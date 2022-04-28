import 'package:flutter/material.dart';
import 'package:pepper_house/repository/cart_repo.dart';
import 'package:pepper_house/screen/cart_items.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import '../models/menu.dart';
import 'check_out.dart';
//import 'package:pepper_house/components/top_menu.dart';

class FoodDetailPage extends StatefulWidget {
  final Menu menu;
  const FoodDetailPage({Key? key, required this.menu}) : super(key: key);

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  var txt = TextEditingController();
  final TextEditingController _quantityController =
      TextEditingController(text: "1");
  /* String _cartCount = locator.get<CartRepo>().countCart; */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Details",
        ),
        automaticallyImplyLeading: true,
        actions: [
          Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const CartItemsPage()));
                          /*  pushNewScreen(
                        context,
                        screen: const CartItemsPage(),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );  */
                        },
                        child: const Icon(
                          Icons.shopping_cart_checkout,
                          size: 40,
                          color: Colors.black,
                        ))),
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: ClipOval(
                      child: Container(
                        height: 14,
                        width: 14,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              context.watch<CartRepo>().countCart,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500),
                            )),
                      ),
                    ),
                  )),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(children: [
            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Image.network(
                        widget.menu.imageUrl,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return const Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: CircularProgressIndicator()));
                          }
                        },
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            SizedBox(
                              width: 120,
                              height: 30,
                              child: TextField(
                                controller: _quantityController,
                                autofocus: true,
                                textAlign: TextAlign.center,
                                enableInteractiveSelection: false,
                                showCursor: false,
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(left: 5),
                                  prefixIcon: GestureDetector(
                                    onTap: () {
                                      int num;
                                      if (int.parse(_quantityController.text) >=
                                              2 &&
                                          _quantityController.text.isNotEmpty) {
                                        num =
                                            int.parse(_quantityController.text);
                                        num--;
                                        _quantityController.text =
                                            num.toString();
                                      } else if (int.parse(
                                                  _quantityController.text) ==
                                              1 &&
                                          _quantityController.text.isNotEmpty) {
                                        num = 1;
                                        _quantityController.text =
                                            num.toString();
                                      }
                                    },
                                    child: const Icon(
                                      Icons.remove,
                                      size: 16,
                                    ),
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      int val;
                                      if (_quantityController.text.isEmpty) {
                                        val = 1;
                                        _quantityController.text =
                                            val.toString();
                                      } else {
                                        val =
                                            int.parse(_quantityController.text);
                                        val++;
                                        _quantityController.selection =
                                            TextSelection.fromPosition(
                                                TextPosition(
                                                    offset: _quantityController
                                                        .text.length));
                                        _quantityController.text =
                                            val.toString();
                                      }
                                    },
                                    child: const Icon(
                                      Icons.add,
                                      size: 16,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide: const BorderSide(
                                        color: Colors.red, width: 2),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                // Only numbers can be entered
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              child: TextButton(
                                child: const Icon(
                                  Icons.shopping_cart,
                                  size: 24,
                                  color: Colors.yellow,
                                ),
                                onPressed: () {
                                  int quantity =
                                      int.parse(_quantityController.text);
                                  int price = int.parse(widget.menu.price);
                                  int total = quantity * price;
                                  context.read<CartRepo>().addToCart(
                                      menuId: widget.menu.id,
                                      description: widget.menu.description,
                                      imageUrl: widget.menu.imageUrl,
                                      name: widget.menu.name,
                                      price: widget.menu.price,
                                      quantity: _quantityController.text,
                                      total: total.toString());
                                  setState(() {});
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  elevation: 10,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32.0)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
            const SizedBox(
              height: 5,
            ),
            Row(children: [
              Text(
                widget.menu.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              RichText(
                  text: const TextSpan(children: [
                WidgetSpan(
                    child: Icon(
                  Icons.star,
                  color: Colors.red,
                  size: 18,
                )),
                WidgetSpan(
                    child: Icon(
                  Icons.star,
                  color: Colors.red,
                  size: 18,
                )),
                WidgetSpan(
                    child: Icon(
                  Icons.star,
                  color: Colors.red,
                  size: 18,
                )),
                WidgetSpan(
                    child: Icon(
                  Icons.star,
                  color: Colors.red,
                  size: 18,
                )),
                WidgetSpan(
                    child: Icon(
                  Icons.star_outline,
                  color: Colors.red,
                  size: 18,
                ))
              ])),
            ]),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.menu.price,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    letterSpacing: 2),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Description",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.menu.description,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        elevation: 10,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        fixedSize:
                            Size(MediaQuery.of(context).size.width * 0.6, 50),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const CheckOutPage()));
                      },
                      child: const Text(
                        'Proceed',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    )),
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        elevation: 10,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        fixedSize:
                            Size(MediaQuery.of(context).size.width * 0.2, 50),
                      ),
                      onPressed: () {},
                      child: const Icon(
                        Icons.phone_callback_outlined,
                        size: 30,
                        color: Colors.black87,
                      ),
                    )),
              ],
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  "Popular",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              height: 250,
              child: GridView(
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250,
                    childAspectRatio: 1,
                    mainAxisExtent: 200,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20),
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          child: SizedBox(
                            height: 120,
                            width: 150,
                            child: Image.asset(
                              "asset/images/efo.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 5),
                                child: const Text(
                                  "Efo riro",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ))),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                              ),
                              child: RichText(
                                  text: const TextSpan(children: [
                                WidgetSpan(
                                    child: Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 18,
                                )),
                                WidgetSpan(
                                    child: Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 18,
                                )),
                                WidgetSpan(
                                    child: Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 18,
                                )),
                                WidgetSpan(
                                    child: Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 18,
                                )),
                                WidgetSpan(
                                    child: Icon(
                                  Icons.star_outline,
                                  color: Colors.red,
                                  size: 18,
                                ))
                              ])),
                            )),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("3500"),
                              SizedBox(
                                width: 80,
                                height: 30,
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  enableInteractiveSelection: false,
                                  showCursor: false,
                                  autofocus: false,
                                  controller: txt,
                                  decoration: InputDecoration(
                                    prefix: GestureDetector(
                                      onTap: () {
                                        int num = txt.text.isEmpty
                                            ? 0
                                            : int.parse(txt.text);
                                        if (num >= 1) {
                                          var val = num--;
                                          txt.selection =
                                              TextSelection.fromPosition(
                                                  TextPosition(
                                                      offset: txt.text.length));
                                          txt.text = val.toString();
                                        }
                                      },
                                      child: const Icon(
                                        Icons.remove,
                                        size: 16,
                                      ),
                                    ),
                                    suffix: GestureDetector(
                                      onTap: () {
                                        int val;
                                        if (txt.text.isEmpty) {
                                          val = 1;
                                          txt.text = val.toString();
                                        } else {
                                          val = int.parse(txt.text);
                                          val++;
                                          txt.selection =
                                              TextSelection.fromPosition(
                                                  TextPosition(
                                                      offset: txt.text.length));
                                          txt.text = val.toString();
                                        }
                                      },
                                      child: const Icon(
                                        Icons.add,
                                        size: 16,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 2),
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  // Only numbers can be entered
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 120,
                          width: 150,
                          child: Image.asset("asset/images/jollof.jpg",
                              fit: BoxFit.cover),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 5),
                                child: const Text(
                                  "Nigerian Jollof Rice",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ))),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                              ),
                              child: RichText(
                                  text: const TextSpan(children: [
                                WidgetSpan(
                                    child: Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 18,
                                )),
                                WidgetSpan(
                                    child: Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 18,
                                )),
                                WidgetSpan(
                                    child: Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 18,
                                )),
                                WidgetSpan(
                                    child: Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 18,
                                )),
                                WidgetSpan(
                                    child: Icon(
                                  Icons.star_outline,
                                  color: Colors.red,
                                  size: 18,
                                ))
                              ])),
                            ))
                      ],
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 120,
                          width: 150,
                          child: Image.asset("asset/images/beans.jpg",
                              fit: BoxFit.cover),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 5),
                                child: const Text(
                                  "Beans",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ))),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                              ),
                              child: RichText(
                                  text: const TextSpan(children: [
                                WidgetSpan(
                                    child: Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 18,
                                )),
                                WidgetSpan(
                                    child: Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 18,
                                )),
                                WidgetSpan(
                                    child: Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 18,
                                )),
                                WidgetSpan(
                                    child: Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 18,
                                )),
                                WidgetSpan(
                                    child: Icon(
                                  Icons.star_outline,
                                  color: Colors.red,
                                  size: 18,
                                ))
                              ])),
                            )),
                      ],
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 120,
                          width: 150,
                          child: Image.asset("asset/images/amala.jpg",
                              fit: BoxFit.cover),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 5),
                                child: const Text(
                                  "Amala and Ewedu",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ))),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                              ),
                              child: RichText(
                                  text: const TextSpan(children: [
                                WidgetSpan(
                                    child: Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 18,
                                )),
                                WidgetSpan(
                                    child: Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 18,
                                )),
                                WidgetSpan(
                                    child: Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 18,
                                )),
                                WidgetSpan(
                                    child: Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 18,
                                )),
                                WidgetSpan(
                                    child: Icon(
                                  Icons.star_outline,
                                  color: Colors.red,
                                  size: 18,
                                ))
                              ])),
                            ))
                      ],
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 120,
                          width: 150,
                          child: Image.asset("asset/images/semo.jpg",
                              fit: BoxFit.cover),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 5),
                                child: const Text(
                                  "Semovita",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ))),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                              ),
                              child: RichText(
                                  text: const TextSpan(children: [
                                WidgetSpan(
                                    child: Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 18,
                                )),
                                WidgetSpan(
                                    child: Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 18,
                                )),
                                WidgetSpan(
                                    child: Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 18,
                                )),
                                WidgetSpan(
                                    child: Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 18,
                                )),
                                WidgetSpan(
                                    child: Icon(
                                  Icons.star_outline,
                                  color: Colors.red,
                                  size: 18,
                                ))
                              ])),
                            ))
                      ],
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 120,
                          width: 150,
                          child: Image.asset(
                            "asset/images/efo.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                              ),
                              child: RichText(
                                  text: const TextSpan(children: [
                                WidgetSpan(
                                    child: Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 18,
                                )),
                                WidgetSpan(
                                    child: Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 18,
                                )),
                                WidgetSpan(
                                    child: Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 18,
                                )),
                                WidgetSpan(
                                    child: Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 18,
                                )),
                                WidgetSpan(
                                    child: Icon(
                                  Icons.star_outline,
                                  color: Colors.red,
                                  size: 18,
                                ))
                              ])),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ]),
        ),
      ),
    );
  }
}
