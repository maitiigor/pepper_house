import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pepper_house/locator.dart';
import 'package:pepper_house/repository/cart_repo.dart';
import 'package:pepper_house/repository/order_detail_repo.dart';
import 'package:pepper_house/repository/order_repo.dart';
import 'package:pepper_house/screen/getstarted.dart';
import 'package:pepper_house/shapes/frontpage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pepper_house/splash.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp();
  setUpServices();
   runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartRepo()),
        ChangeNotifierProvider(create: (_) => OrderRepository()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: const SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black38,
    primary: Colors.black54,
    minimumSize: const Size(100, 50),
    padding: const EdgeInsets.symmetric(horizontal: 50),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Material(
        child: SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: CustomPaint(
        painter: FrontPagePainter(),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: SvgPicture.asset(
                "asset/svg/delivery.svg",
              ),
            ),
            Row(
              children: [
                Container(width: MediaQuery.of(context).size.width * 0.2),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.width * 1,
                  padding: const EdgeInsets.only(right: 4),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Card(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.asset(
                          "asset/images/logo.jpeg",
                          fit: BoxFit.fill,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      elevation: 10,
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => GetStarted()));
                },
                style: raisedButtonStyle,
                child: RichText(
                    text: const TextSpan(children: [
                  TextSpan(
                      text: "Get Started",
                      style: TextStyle(fontSize: 25, fontFamily: "Tahoma")),
                  WidgetSpan(
                      child: Icon(Icons.arrow_forward,
                          size: 25, color: Colors.yellow)),
                ])))
          ],
        ),
      ),
    ));
  }
}
