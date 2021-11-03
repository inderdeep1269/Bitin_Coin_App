import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bitin_coin_app/screens/XCoin_home.dart';
import 'package:bitin_coin_app/screens/authentication/login.dart';
import 'package:bitin_coin_app/services/auth.dart';
import 'package:bitin_coin_app/widgets/square_loading.dart';

class Root extends StatefulWidget {
  const Root({ Key? key }) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {

  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().user,
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active){
          if (snapshot.data?.uid == null){
            return const Login();
          }
          else{
            return const XCoinHomePage();
          }
        }
        return const Scaffold(
          body: SquareLoading()
        );
      }
    );
  }
}