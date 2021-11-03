import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bitin_coin_app/constants/global_var.dart';
import 'package:bitin_coin_app/services/auth.dart';
import 'package:bitin_coin_app/services/theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class XCoinDrawer extends StatefulWidget {
  const XCoinDrawer({Key? key}) : super(key: key);

  @override
  _XCoinDrawerState createState() => _XCoinDrawerState();
}

class _XCoinDrawerState extends State<XCoinDrawer> {

  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clientEmail = prefs.getString('clientEmail') ?? "x";
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    final _theme = Provider.of<ThemeProvider>(context);
    final isXCoinDark = (_theme.getTheme() == ThemeData.dark());

    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: const Text(''),
            accountEmail: Text(
              clientEmail,
                style: const TextStyle(
                  fontSize: 22,
                )),
            currentAccountPicture: CircleAvatar(
              backgroundColor: const Color(0xFF0f03ad),
              child: Text(
                clientEmail[0].toUpperCase(),
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
          ),
          SizedBox(
            height: _height * 0.6,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: FlatButton(
                      splashColor: Colors.grey.withOpacity(0.01),
                      hoverColor: Colors.grey.withOpacity(0.01),
                      focusColor: Colors.grey.withOpacity(0.01),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: SizedBox(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              Icons.home_outlined,
                              size: 20,
                            ),
                            SizedBox(width: _width * 0.05),
                            const Text('Home',
                                style: TextStyle(
                                  fontSize: 15,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Divider(
                        height: 2,
                        thickness: 1,
                        color: isXCoinDark ? Colors.white54 : Colors.black54),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: FlatButton(
                      splashColor: Colors.grey.withOpacity(0.01),
                      hoverColor: Colors.grey.withOpacity(0.01),
                      focusColor: Colors.grey.withOpacity(0.01),
                      onPressed: () {
                        // GO TO Friends Page << XCoinNetworkPage >> ....................
                      },
                      child: SizedBox(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              Icons.account_tree_outlined,
                              size: 20,
                            ),
                            SizedBox(width: _width * 0.05),
                            const Text('Network',
                                style: TextStyle(
                                  fontSize: 15,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Divider(
                        height: 2,
                        thickness: 1,
                        color: isXCoinDark ? Colors.white54 : Colors.black54),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: FlatButton(
                      splashColor: Colors.grey.withOpacity(0.01),
                      hoverColor: Colors.grey.withOpacity(0.01),
                      focusColor: Colors.grey.withOpacity(0.01),
                      onPressed: () {
                        // GO TO Website of << XCoin >> ....................
                      },
                      child: SizedBox(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              Icons.article_outlined,
                              size: 20,
                            ),
                            SizedBox(width: _width * 0.05),
                            const Text('White Paper',
                                style: TextStyle(
                                  fontSize: 15,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Divider(
                        height: 2,
                        thickness: 1,
                        color: isXCoinDark ? Colors.white54 : Colors.black54),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: FlatButton(
                      splashColor: Colors.grey.withOpacity(0.01),
                      hoverColor: Colors.grey.withOpacity(0.01),
                      focusColor: Colors.grey.withOpacity(0.01),
                      onPressed: () async {
                        // GO TO Website of << XCoin >> /\/\/\/\/\/\/\/\/\/\/\*********************
                        //******************************************
                        //**********************************************
                        // */ */...website of appp..................................................
                        const url = 'https://google.com';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'cannot open url:- $url';
                        }
                      },
                      child: SizedBox(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              Icons.info_outline,
                              size: 20,
                            ),
                            SizedBox(width: _width * 0.05),
                            const Text('About Us',
                                style: TextStyle(
                                  fontSize: 15,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Divider(
                        height: 2,
                        thickness: 1,
                        color: isXCoinDark ? Colors.white54 : Colors.black54),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: FlatButton(
                      splashColor: Colors.grey.withOpacity(0.01),
                      hoverColor: Colors.grey.withOpacity(0.01),
                      focusColor: Colors.grey.withOpacity(0.01),
                      onPressed: () {
                        if (isXCoinDark) {
                          _theme.setTheme(ThemeData.light());
                        } else {
                          _theme.setTheme(ThemeData.dark());
                        }
                      },
                      child: SizedBox(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              isXCoinDark
                                  ? Icons.light_mode_outlined
                                  : Icons.dark_mode_outlined,
                              size: 20,
                            ),
                            SizedBox(width: _width * 0.05),
                            Text(isXCoinDark ? 'Light Mode' : 'Dark Mode',
                                style: const TextStyle(
                                  fontSize: 15,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Divider(
                        height: 2,
                        thickness: 1,
                        color: isXCoinDark ? Colors.white54 : Colors.black54),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: FlatButton(
                      splashColor: Colors.grey.withOpacity(0.01),
                      hoverColor: Colors.grey.withOpacity(0.01),
                      focusColor: Colors.grey.withOpacity(0.01),
                      onPressed: () async {
                        // GO TO Website of << XCoin >> ....................
                        await AuthService().signOut();
                        setState(() {});
                      },
                      child: SizedBox(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              Icons.exit_to_app_outlined,
                              size: 20,
                            ),
                            SizedBox(width: _width * 0.05),
                            const Text('Sign Out',
                                style: TextStyle(
                                  fontSize: 15,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: _height * 0.08,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Divider(
                      height: 2,
                      thickness: 1,
                      color: isXCoinDark ? Colors.white54 : Colors.black54),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                        child: Image.asset('assets/reddit.png'),
                      ),
                      SizedBox(
                        height: 40,
                        child: Image.asset('assets/twitter.png'),
                      ),
                      SizedBox(
                        height: 43,
                        child: Image.asset('assets/telegram.png'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
