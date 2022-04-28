import 'package:flutter/material.dart';
import 'package:pepper_house/screen/food_detail.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({Key? key}) : super(key: key);

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  var txt = TextEditingController();
  bool checkValue = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
           Stack(
             children: [
               Container(
                 height: 60,
                 decoration: const BoxDecoration(
                   color: Colors.red
                 ),
               ),
               Align(
                 alignment: Alignment.center,
                 child: Padding(
                   padding: const EdgeInsets.only(top: 10),
                   child: SizedBox(
                     height: 100,
                     width: 200,
                     child: ClipOval(child: Image.asset("asset/images/logo.jpeg", fit: BoxFit.fill))),
                 ),
               ),
                Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8,right: 10),
                  child: GestureDetector(
                    onTap: () {
                      
                    },
                    child: const Icon(Icons.shopping_cart_checkout,size: 40))),
              ),
                Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8,right: 15),
                  child: ClipOval(
                    child: Container(
                      height: 12,
                      width: 12,
                      decoration: const BoxDecoration(
                        color: Colors.white
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text("1",style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500),)),
                    ),
                  ),)
              ),
             ],
           ),
          /* Container(
            margin: const EdgeInsets.only(top: 5, bottom: 5),
            child: const Text(
              "PEPPER HOUSE DELICACIES",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.red, fontSize: 30, fontWeight: FontWeight.w800),
            ),
          ), */
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
          GridView.count(
            scrollDirection: Axis.vertical,
            crossAxisCount: 5,
            childAspectRatio: 0.8,
            shrinkWrap: true,
            padding: const EdgeInsets.all(2),
            children: List.generate(5, (index) {
              return Stack(
                fit: StackFit.loose,
                alignment: Alignment.topCenter,
                children: [
                  Card(
                    child: SizedBox(
                      height: 60,
                      child: Image.asset("asset/images/logo.jpeg"),
                    ),
                    elevation: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 70),
                    child: const Text(
                      "Rice",
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                ],
              );
            }),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: const Text(
                "Menus",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
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
                  child: GestureDetector(
                    onTap: () {
                      /* pushNewScreen(
                        context,
                        screen: const FoodDetailPage(),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      ); */

                      /*  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const FoodDetailPage())); */
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Checkbox(
                            value: checkValue,
                            onChanged: (value) {
                              setState(() {
                                checkValue == true
                                    ? checkValue = false
                                    : checkValue = true;
                              });
                            },
                          ),
                        ),
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
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Checkbox(
                          value: checkValue,
                          onChanged: (value) {
                            setState(() {
                              checkValue == true
                                  ? checkValue = false
                                  : checkValue = true;
                            });
                          },
                        ),
                      ),
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
          /*  GridView.count(
            scrollDirection: Axis.horizontal,

            crossAxisCount: 2,
            mainAxisSpacing: 5,
            shrinkWrap: true,

            children: List.generate(5, (index) {
              return Stack(
                fit: StackFit.loose,
                alignment: Alignment.topCenter,
                children: [
                  Card(
                    child: Container(
                      height: 150,
                      child: Image.asset("asset/images/logo.jpeg"),
                    ),
                    margin: const EdgeInsets.all(5),
                    elevation: 5,
                  ),
                ],
              );
            }),
          ), */
        ],
      ),
    );
  }
}
