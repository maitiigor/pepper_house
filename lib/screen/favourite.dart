import 'package:flutter/material.dart';
import 'package:pepper_house/locator.dart';
import 'package:provider/provider.dart';
import 'package:pepper_house/repository/order_repo.dart';

import '../models/order.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
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
              ],
            ),
            FutureBuilder<List<Order>>(
              future: context.watch<OrderRepository>().retrieveOrder(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 15),
                      child: Column(
                        children: [
                          const Text(
                            "Orders",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.8,
                              child: ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    String status =
                                        snapshot.data![index].isFufilled
                                            ? "pending"
                                            : "delivered";
                                    List<Widget> _orderdetail = [];
                                    _orderdetail.add(Align(
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                          text: TextSpan(children: [
                                        const TextSpan(
                                            text: 'Order Id :',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            )),
                                        TextSpan(
                                            text: snapshot.data![index].id,
                                            style: const TextStyle(
                                                color: Colors.black)),
                                      ])),
                                    ));
                                    _orderdetail.add(const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Order details',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              height: 1.5)),
                                    ));

                                    for (var i = 0;
                                        i <
                                            snapshot.data![index].orderDetail
                                                .length;
                                        i++) {
                                      _orderdetail.add(Align(
                                        alignment: Alignment.centerLeft,
                                        child: RichText(
                                            text: TextSpan(children: [
                                          TextSpan(
                                              text: snapshot.data![index]
                                                      .orderDetail[i].menuId +
                                                  " ",
                                              style: const TextStyle(
                                                  color: Colors.black)),
                                          TextSpan(
                                              text: snapshot.data![index]
                                                      .orderDetail[i].price +
                                                  ' x ' +
                                                  snapshot.data![index]
                                                      .orderDetail[i].quantity +
                                                  ' = ' +
                                                  snapshot
                                                      .data![index]
                                                      .orderDetail[i]
                                                      .totalAmount,
                                              style: const TextStyle(
                                                  color: Colors.black))
                                        ])),
                                      ));
                                    }
                                    _orderdetail.add(Align(
                                        alignment: Alignment.centerLeft,
                                        child: RichText(
                                          text: TextSpan(children: [
                                            const TextSpan(
                                                text: 'Total amount : ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    height: 1.5,
                                                    color: Colors.black)),
                                            TextSpan(
                                                text: snapshot
                                                    .data![index].totalAmount,
                                                style: const TextStyle(
                                                    color: Colors.black)),
                                          ]),
                                        )));
                                    _orderdetail.add(Align(
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                        text: TextSpan(children: [
                                          const TextSpan(
                                              text: 'Status : ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                          TextSpan(
                                              text: status,
                                              style: const TextStyle(
                                                  color: Colors.black))
                                        ]),
                                      ),
                                    ));
                                    return Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(children: _orderdetail),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: SizedBox(
                      height: 50,
                      width: 100,
                      child: Text(
                        "No order has been made yet",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
