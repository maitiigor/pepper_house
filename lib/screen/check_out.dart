import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pepper_house/controller/user_controller.dart';
import 'package:pepper_house/locator.dart';
import 'package:pepper_house/models/order_detail.dart';
import 'package:pepper_house/repository/order_repo.dart';
import 'package:pepper_house/screen/payment.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import '../models/cart_model.dart';
import '../models/order.dart';
import '../repository/cart_repo.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  var publicKey = 'pk_test_fe2267ad8198977f81af6bd46ad79d42bbc54228';
  final plugin = PaystackPlugin();

  @override
  void initState() {
    plugin.initialize(publicKey: publicKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Make Payment"),
        automaticallyImplyLeading: true,
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 5,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Card or bank transfer',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          width: 50,
                          height: 50,
                          child: Image.asset('asset/images/mastercard.png'),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          width: 50,
                          height: 50,
                          child: Image.asset('asset/images/visacard.png'),
                        ),
                      ],
                    ),
                    const Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut id lacinia risus. Praesent eget ante orci. Suspendisse varius libero sit amet felis fermentum pellentesque. Quisque pharetra odio vitae orci cursus, vel porta purus lacinia. Quisque efficitur iaculis mi vitae aliquam. Ut aliquet nisl et ornare tristique. Cras posuere sapien facilisis, tempor metus nec, ultricies urna. Vestibulum accumsan in mi sit amet porta. Curabitur sed neque sed risus finibus scelerisque")
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 5,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Cash on delivery',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut id lacinia risus. Praesent eget ante orci. Suspendisse varius libero sit amet felis fermentum pellentesque. Quisque pharetra odio vitae orci cursus, vel porta purus lacinia. Quisque efficitur iaculis mi vitae aliquam. Ut aliquet nisl et ornare tristique. Cras posuere sapien facilisis, tempor metus nec, ultricies urna. Vestibulum accumsan in mi sit amet porta. Curabitur sed neque sed risus finibus scelerisque")
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "use a voucher",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                suffixIcon: SizedBox(
                  height: 50,
                  width: 100,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Apply",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      /*    elevation: 10, */
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                      ),
                      //fixedSize: Size(MediaQuery.of(context).size.width * 0.8, 50),
                    ),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                ),
                labelText: 'Voucher code',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Sub-total",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("#7500")
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Deliery",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("#500")
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Total",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("#8000")
                ],
              ),
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
                          horizontal: 5,
                        ),
                        elevation: 10,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        fixedSize:
                            Size(MediaQuery.of(context).size.width * 0.5, 50),
                      ),
                      onPressed: () async {
                        /*  Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const PaymentPage())); */
                        int amount =
                            int.parse(context.read<CartRepo>().totalAmount());
                        Charge charge = Charge()
                          ..amount = amount * 100
                          ..reference = _getReference()
                          // or ..accessCode = _getAccessCodeFrmInitialization()
                          ..email =
                              locator.get<UserController>().currentUser.email;
                        CheckoutResponse response = await plugin.checkout(
                          context,
                          method: CheckoutMethod
                              .card, // Defaults to CheckoutMethod.selectable
                          charge: charge,
                        );
                        if (response.reference != null) {
                          print(response.reference);
                          var verification = await _verifyPayment(
                              response.reference, publicKey);
                          var date =
                              utf8.encode(DateTime.now().toString()).join();
                          List<OrderDetail> orderDetail = [];
                          List<CartModel> cart = context.read<CartRepo>().carts;
                          for (var i = 0; i < cart.length; i++) {
                            orderDetail.add(OrderDetail(
                                menuId: cart[i].menuId,
                                menuName: cart[i].name,
                                price: cart[i].price,
                                quantity: cart[i].quantity,
                                totalAmount: cart[i].total));
                          }
                          DocumentReference doc = await context
                              .read<OrderRepository>()
                              .addOrder(Order(
                                  id: date,
                                  userId: locator
                                      .get<UserController>()
                                      .currentUser
                                      .uid,
                                  orderDetail: orderDetail,
                                  paymentReference:
                                      response.reference.toString(),
                                  totalAmount: amount.toString(),
                                  isFufilled: false,
                                  createdAt: Timestamp.now(),
                                  updatedAt: Timestamp.now()));
                          //print(verification);
                          // context.read<CartRepo>().emptyCart();
                          if (doc.id.isNotEmpty) {
                            _showMyDialog(true);
                          } else {
                            _showMyDialog(false);
                          }
                        }
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
                          horizontal: 5,
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
            )
          ]),
        ),
      ),
    );
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  Future<String> createAccessCode(skTest, _getReference, email, amount) async {
    // skTest -> Secret key
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $skTest'
    };
    Map data = {"amount": email, "email": amount, "reference": _getReference};
    String payload = json.encode(data);
    http.Response response = await http.post(
        Uri.https('api.paystack.co', '/transaction/initialize'),
        headers: headers,
        body: payload);
    final Map res = jsonDecode(response.body);
    String accessCode = res['data']['access_code'];
    return accessCode;
  }

  Future _verifyPayment(String? refrence, skTest) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $skTest'
    };
    http.Response response = await http.get(
      Uri.https('api.paystack.co', '/transaction/verify/$refrence'),
      headers: headers,
    );
    final Map res = jsonDecode(response.body);
    return res;
  }

  Future<void> _showMyDialog(bool status) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(status ? "Payment Sucessful" : "Error ocurreds"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(status
                    ? "The Order Payment Transaction was successful."
                    : "Unable to confirm transaction"),
                Text(status ? 'Your Order is on the way' : ''),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
