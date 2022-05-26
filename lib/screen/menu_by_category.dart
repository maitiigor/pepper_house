import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pepper_house/locator.dart';
import 'package:pepper_house/repository/cart_repo.dart';
import 'package:pepper_house/models/menu.dart';
import 'package:pepper_house/repository/menu_repo.dart';
import 'package:provider/provider.dart';

import '../models/menu_category_model.dart';

class MenuByCategory extends StatefulWidget {
  const MenuByCategory({Key? key, required this.category}) : super(key: key);
  final MenuCategory category;
  @override
  State<MenuByCategory> createState() => _MenuByCategoryState();
}

class _MenuByCategoryState extends State<MenuByCategory> {
  List<Menu> _retrievedMenuList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
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
          FutureBuilder(
              future: locator
                  .get<MenuRepository>()
                  .getMenuByCategory(widget.category.id),
              builder: ((context, AsyncSnapshot<List<Menu>> snapshot) {
                if (snapshot.hasData) {
                  _retrievedMenuList = snapshot.data!;
                  if (snapshot.data!.isEmpty) {
                    return const Text("No Menu found in this category");
                  } else {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.76,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                             SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.9,
                          mainAxisExtent: 200,
                          crossAxisSpacing: 5,
                          mainAxisSpacing:  10,
                        ),
                    
                        itemCount: _retrievedMenuList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: SizedBox(
                              height: 100,
                              width: 70,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 100,
                                      width: MediaQuery.of(context).size.width,
                                      child: Image.network(
                                          _retrievedMenuList[index].imageUrl,
                                          fit: BoxFit.cover),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                }
                if (snapshot.hasError) {
                  return const Text(
                      "Something went wrong please try again later");
                } else {
                  return const CircularProgressIndicator();
                }
              }))
        ],
      )),
    );
  }
}
