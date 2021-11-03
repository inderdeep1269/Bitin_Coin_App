import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:bitin_coin_app/root.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bitin_coin_app/services/theme_provider.dart';

bool isXCoinDark = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('isXCoinDark')) {
    isXCoinDark = prefs.getBool('isXCoinDark') ?? false;
  } else {
    prefs.setBool(
      'isXCoinDark',
      false,
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData getTheme() => (isXCoinDark) ? ThemeData.dark() : ThemeData.light();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ThemeProvider(getTheme()))
      ],
      child: const XCoinApp(),
    );
  }
}

class XCoinApp extends StatefulWidget {
  const XCoinApp({Key? key}) : super(key: key);

  @override
  _XCoinAppState createState() => _XCoinAppState();
}

class _XCoinAppState extends State<XCoinApp> {

  final Future<FirebaseApp> _initFire = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    final _theme = Provider.of<ThemeProvider>(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _theme.getTheme(),
      home: FutureBuilder(
        future: _initFire,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const Root();
          }
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(height: 15,),
                  Text('Loading...', style: TextStyle(fontSize: 25,)),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
