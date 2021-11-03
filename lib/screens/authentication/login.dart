import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bitin_coin_app/constants/global_var.dart';
import 'package:bitin_coin_app/exception/auth_exception_handler.dart';
import 'package:bitin_coin_app/model/exception_data.dart';
import 'package:bitin_coin_app/screens/authentication/register.dart';
import 'package:bitin_coin_app/services/auth.dart';
import 'package:bitin_coin_app/services/theme_provider.dart';
import 'package:bitin_coin_app/widgets/square_loading.dart';

class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isObscure = true;

  var islight = true;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          isLoading = false;
        });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final _theme = Provider.of<ThemeProvider>(context);
    final isDark = (_theme.getTheme() == ThemeData.dark());
    islight = !isDark;
    
    return isLoading ? const Scaffold(
      body: SquareLoading(),
    ):
    Scaffold(
      backgroundColor: isDark ? Colors.black87 : Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    if (isDark) {
                      prefs.setBool('isTaskDark', false);
                      _theme.setTheme(ThemeData.light());
                    } else {
                      prefs.setBool('isTaskDark', true);
                      _theme.setTheme(ThemeData.dark());
                    }
                    setState(() {});
                  },
                  child: isDark ? const Icon(Icons.light_mode_outlined, size: 50): const Icon(Icons.dark_mode_outlined, size: 50,),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon: const Icon(Icons.mail_outline_outlined),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: isDark?Colors.white:Colors.black),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: isDark?Colors.white:Colors.black),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: isDark?Colors.white:Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: isDark?Colors.white:Colors.black),
                    ),
                    
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: isDark?Colors.white:Colors.black),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: isDark?Colors.white:Colors.black),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: isDark?Colors.white:Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: isDark?Colors.white:Colors.black),
                    ),
                    
                  ),
                ),
                const SizedBox(height: 30),
                RaisedButton(
                  child: const Text('Sign In', style: TextStyle(fontSize: 15)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.lightBlueAccent,
                  onPressed: () async {
                    final AuthResultStatus res = await AuthService().signIn(email: _emailController.text, password: _passwordController.text);
                    if (_emailController.text.isEmpty) {
                      Get.snackbar(
                        'Warning!', 
                        'Email field is empty!!!',
                        duration: const Duration(seconds: 10),
                        animationDuration: const Duration(seconds: 3),
                        onTap: null,
                        snackPosition: SnackPosition.TOP,
                      );
                    }
                    else if (_passwordController.text.isEmpty) {
                      Get.snackbar(
                        'Warning!', 
                        'Password field is empty!!!',
                        duration: const Duration(seconds: 10),
                        animationDuration: const Duration(seconds: 3),
                        onTap: null,
                        snackPosition: SnackPosition.TOP,
                      );
                    }
                    else if (res == AuthResultStatus.successful) {
                      clientEmail = _emailController.text;
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setString('clientEmail', _emailController.text);
                      _emailController.clear();
                      _passwordController.clear();
                    }
                    else if (res == AuthResultStatus.userNotFound){
                      Get.snackbar(
                        'Warning!', 
                        AuthExceptionHandler.generateExceptionMessage(res),
                        duration: const Duration(seconds: 7),
                        animationDuration: const Duration(seconds: 2),
                        onTap: (tap) {
                          Get.to(const Register());
                          _emailController.clear();
                          _passwordController.clear();
                          tap.dismissDirection;                        
                        },
                        snackPosition: SnackPosition.TOP,
                      );
                    }
                    else {
                      Get.snackbar(
                        'Warning!', 
                        AuthExceptionHandler.generateExceptionMessage(res),
                        duration: const Duration(seconds: 7),
                        animationDuration: const Duration(seconds: 2),
                        onTap: null,
                        snackPosition: SnackPosition.TOP,
                      );
                    }
                  },
                ),
                const SizedBox(height: 15),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Don\'t have an Account? ',
                        style: TextStyle(
                          color: isDark ? Colors.white: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: 'Create account',
                        style: const TextStyle(
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            _emailController.clear();
                            _passwordController.clear();
                            Get.to(() => const Register());
                          }
                      ),
                    ]
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}