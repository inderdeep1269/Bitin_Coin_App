import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bitin_coin_app/screens/xcoin_announcement_page.dart';
import 'package:bitin_coin_app/screens/xcoin_home_page.dart';
import 'package:bitin_coin_app/screens/xcoin_miner_page.dart';
import 'package:bitin_coin_app/screens/xcoin_wallet_page.dart';
import 'package:bitin_coin_app/services/theme_provider.dart';
import 'package:bitin_coin_app/widgets/xcoin_drawer.dart';

class XCoinHomePage extends StatefulWidget {
  const XCoinHomePage({Key? key}) : super(key: key);

  @override
  _XCoinHomePageState createState() => _XCoinHomePageState();
}

class _XCoinHomePageState extends State<XCoinHomePage> {
  int selectedIndex = 0;

  final _currentPage = [
    const MinerPage(),
    const HomePage(),
    const WalletPage(),
    const AnnouncementPage(),
  ];

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    final _theme = Provider.of<ThemeProvider>(context);
    final isXCoinDark = (_theme.getTheme() == ThemeData.dark());

    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
            centerTitle: true,
            backgroundColor:
                isXCoinDark ? const Color(0xFF10112e) : Colors.blueAccent,
            toolbarHeight: 70,
            leadingWidth: 80,
            elevation: 0.0,
            leading: GestureDetector(
              child: const Icon(Icons.menu, size: 30),
              onTap: () => scaffoldKey.currentState?.openDrawer(),
            ),
            title: SizedBox(
              width: _width * 0.301,
              child: Row(
                children: <Widget>[
                  const Text('1244',
                      style: TextStyle(
                        fontSize: 30,
                      )),
                  Column(
                    children: const <Widget>[
                      Text('.4857', style: TextStyle(fontSize: 19)),
                    ],
                  ),
                ],
              ),
            )),
        drawer: const XCoinDrawer(),
        body: _currentPage[selectedIndex],
        
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.black87,
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.construction_outlined), label: 'Miners'),
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'My Mine'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_outlined), label: 'Wallet'),
            BottomNavigationBarItem(
                icon: Icon(Icons.announcement_outlined), label: 'Announcements')
          ],
        ),
      ),
    );
  }
}
