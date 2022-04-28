import 'package:flutter/material.dart';
import 'package:pepper_house/screen/register.dart';
import 'package:pepper_house/shapes/loginpageshape.dart';

import 'login.dart';

class GetStarted extends StatelessWidget {
  GetStarted({Key? key}) : super(key: key);
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black38,
    primary: Colors.red,
    minimumSize: const Size(300, 50),
    padding: const EdgeInsets.symmetric(horizontal: 20),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: CustomPaint(
                painter: LoginPagePainter(),
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const RegisterPage()));
                  },
                  child: const Text(
                    'Create an account',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                )),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    elevation: 10,
                    side: const BorderSide(color: Colors.red, width: 2),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    fixedSize:
                        Size(MediaQuery.of(context).size.width * 0.6, 50),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LoginPage()));
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.red, fontSize: 22),
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
              child: Text(
                "Or sign-up with",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: null,
                  child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      height: 30,
                      child: Image.asset("asset/images/google.png")),
                ),
                GestureDetector(
                  onTap: null,
                  child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      height: 25,
                      child: Image.asset("asset/images/facebook.png")),
                ),
                GestureDetector(
                  onTap: null,
                  child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      height: 25,
                      width: 30,
                      child: Image.asset("asset/images/twitter.png")),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
