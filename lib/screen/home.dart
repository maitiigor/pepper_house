import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pepper_house/locator.dart';
import 'package:pepper_house/models/menu_category_model.dart';
import 'package:pepper_house/models/quantity_controller_model.dart';
import 'package:pepper_house/models/user_model.dart';
import 'package:pepper_house/repository/cart_repo.dart';
import 'package:pepper_house/repository/menu_category_repo.dart';
import 'package:pepper_house/repository/menu_repo.dart';
import 'package:pepper_house/screen/food_detail.dart';
import 'package:pepper_house/screen/menu_by_category.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../controller/user_controller.dart';
import 'package:provider/provider.dart';
import '../models/menu.dart';
import 'check_out.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final String? _username;

  var txt = TextEditingController();
  final List<QuantityControllerModel> _quantityController = [];
  final UserModel _currentUser = locator.get<UserController>().currentUser;
  Future<List<Menu>>? _menuList;
  List<Menu>? _retrievedMenuList;
  List<MenuCategory> _menuCategoryList = [];
  /* final String _cartCount = locator.get<String>(); */

  Future<void> _initRetrival() async {
    _menuList = locator.get<MenuRepository>().retrieveMenu();
    _retrievedMenuList = await locator.get<MenuRepository>().retrieveMenu();
   
  }

  /*  String? _username = '';
  final String? _welcome = 'Hey';
  var _first_name;
  var _fullName; */
  @override
  void initState() {
    _initRetrival();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 60,
                decoration: const BoxDecoration(color: Colors.red),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                      height: 100,
                      width: 200,
                      child: ClipOval(
                          child: Image.asset("asset/images/logo.jpeg",
                              fit: BoxFit.fill))),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                    padding: const EdgeInsets.only(top: 8, right: 10),
                    child: GestureDetector(
                        onTap: () {},
                        child: const Icon(Icons.shopping_cart_checkout,
                            size: 40))),
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, right: 15),
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
                          ),

                          /*  child: Text(
                              _cartCount,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500),
                            ) */
                        ),
                      ),
                    ),
                  )),
              /*  const Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(top: 8,right: 15),
                  child: Text("1"),)
              ), */
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "Hey " +
                      _currentUser.displayName.toString().split(' ')[0],
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              const TextSpan(
                  text: " what do  want to the eat today",
                  style: TextStyle(fontSize: 12, color: Colors.black)),
            ])),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            height: 60,
            child: Material(
              borderRadius: BorderRadius.circular(30),
              elevation: 15.0,
              shadowColor: Colors.grey.withOpacity(0.7),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'search',
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.red,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                  ),
                ),
              ),
            ),
          ),
          FutureBuilder(
            future: locator.get<MenuCategoryRepository>().retieveMenuCategory(),
            builder: (context, AsyncSnapshot<List<MenuCategory>> snapshot) {       
              if(snapshot.hasData && snapshot.data!.isNotEmpty){
                _menuCategoryList = snapshot.data!;
                return SizedBox(
              height: 80,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _menuCategoryList.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                          padding: const EdgeInsets.all(2),
                          child: SizedBox(
                            width: 80,
                            height: 150,
                            child: Column(
                              children: [
                                Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Container(
                                    height: 50,
                                    width: 80,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: GestureDetector(
                                      onTap: (() {
                                        pushNewScreen(
                                          context,
                                          screen: MenuByCategory(
                                              category: _menuCategoryList[index]),
                                          withNavBar:
                                              true, // OPTIONAL VALUE. True by default.
                                          pageTransitionAnimation:
                                              PageTransitionAnimation.cupertino,
                                        );
                                      }),
                                      child: Image.asset(
                                        "asset/images/logo.jpeg",
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  child: Text(
                                    _menuCategoryList[index].categoryName,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                          ));
                    })),
              ));
              }else{
                return const CircularProgressIndicator();
              }
          },),
          const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text("Recommendations for you",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              )),
          const SizedBox(
            height: 5,
          ),
          FutureBuilder(
              future: _menuList,
              builder: (context, AsyncSnapshot<List<Menu>> snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  for (var item in snapshot.data!) {
                    _quantityController.add(QuantityControllerModel(
                        id: item.id.toString(),
                        controller: TextEditingController(text: "1")));
                  }

                  return SizedBox(
                    height: 220,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _retrievedMenuList!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              pushNewScreen(
                                context,
                                screen: FoodDetailPage(
                                    menu: _retrievedMenuList![index]),
                                withNavBar:
                                    true, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            child: Card(
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
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              progressIndicatorBuilder:
                                                  (context, url, progress) {
                                                return const Align(
                                                    alignment: Alignment.center,
                                                    child: SizedBox(
                                                        height: 30,
                                                        width: 30,
                                                        child:
                                                            CircularProgressIndicator()));
                                              },
                                              imageUrl:
                                                  _retrievedMenuList![index]
                                                      .imageUrl),
                                        )
                                        /*  child: Image.network(
                                        _retrievedMenuList![index].imageUrl,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          } else {
                                            return const Align(
                                                alignment: Alignment.center,
                                                child: SizedBox(
                                                    height: 30,
                                                    width: 30,
                                                    child:
                                                        CircularProgressIndicator()));
                                          }
                                        },
                                        fit: BoxFit.cover,
                                      ), */
                                        ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25, vertical: 5),
                                          child: Text(
                                            _retrievedMenuList![index].name,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(_retrievedMenuList![index].price),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                } /*  else if (snapshot.connectionState == ConnectionState.done &&
                    _retrievedMenuList == null) {
                  return SizedBox(
                    height: 50,
                    child: Center(
                      child: ListView(
                        children: const <Widget>[
                          Align(
                              alignment: AlignmentDirectional.center,
                              child: Text('No data available')),
                        ],
                      ),
                    ),
                  );
                } */
                else {
                  return const SizedBox(
                      height: 220,
                      child: Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              height: 50, child: CircularProgressIndicator())));
                }
              }),
          const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text("Popular",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              )),
          FutureBuilder(
              future: _menuList,
              builder: (context, AsyncSnapshot<List<Menu>> snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return SizedBox(
                    height: 220,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _retrievedMenuList!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              pushNewScreen(
                                context,
                                screen: FoodDetailPage(
                                    menu: _retrievedMenuList![index]),
                                withNavBar:
                                    true, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            child: Card(
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
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              progressIndicatorBuilder:
                                                  (context, url, progress) {
                                                return const Align(
                                                    alignment: Alignment.center,
                                                    child: SizedBox(
                                                        height: 30,
                                                        width: 30,
                                                        child:
                                                            CircularProgressIndicator()));
                                              },
                                              imageUrl:
                                                  _retrievedMenuList![index]
                                                      .imageUrl),
                                        )
                                        /*  child: Image.network(
                                        _retrievedMenuList![index].imageUrl,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          } else {
                                            return const Align(
                                                alignment: Alignment.center,
                                                child: SizedBox(
                                                    height: 30,
                                                    width: 30,
                                                    child:
                                                        CircularProgressIndicator()));
                                          }
                                        },
                                        fit: BoxFit.cover,
                                      ), */
                                        ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25, vertical: 5),
                                          child: Text(
                                            _retrievedMenuList![index].name,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(_retrievedMenuList![index].price),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                } /*  else if (snapshot.connectionState == ConnectionState.done &&
                    _retrievedMenuList == null) {
                  return SizedBox(
                    height: 50,
                    child: Center(
                      child: ListView(
                        children: const <Widget>[
                          Align(
                              alignment: AlignmentDirectional.center,
                              child: Text('No data available')),
                        ],
                      ),
                    ),
                  );
                } */
                else {
                  return const SizedBox(
                      height: 220,
                      child: Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              height: 50, child: CircularProgressIndicator())));
                }
              }),
          /* Row(
            children: [
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
          ), */
        ],
      ),
    );
  }
}
