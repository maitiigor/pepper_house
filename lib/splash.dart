import 'package:flutter/material.dart';
import 'package:pepper_house/enum/auth_result_status.dart';
import 'package:pepper_house/locator.dart';
import 'package:pepper_house/repository/shared_ref.dart';
import 'package:pepper_house/screen/dashboard.dart';
import 'package:pepper_house/screen/login.dart';
import 'package:pepper_house/services/fire_auth.dart';

import 'controller/user_controller.dart';
import 'main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _auth = locator.get<FireAuth>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateHome();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Welcome Screen"),
      ),
    );
  }

  _navigateHome() async {
    await Future.delayed(Duration(milliseconds: 3000), (() {}));
    bool _firsTime = await locator.get<SharedRefRepo>().isFirstTime();
    bool _haslogin = await locator.get<SharedRefRepo>().hasLoginDetails();
    if (!_firsTime && _haslogin) {
      String email = await  locator.get<SharedRefRepo>().getEmail();
      String password = await locator.get<SharedRefRepo>().getPassword();
      AuthResultStatus status =
                              await _auth.signInUsingEmailPassword(
                                  email: email,
                                  password: password,
                                  context: context);
      if (status == AuthResultStatus.successful) {
        await locator.get<UserController>().initUser();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) =>
            const DashboardPage()
            ));
      }
     
    }else if (_firsTime) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const MyHomePage(
                  title: '',
                )));
    } else {
         Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginPage()));
    }
    
  }
}
