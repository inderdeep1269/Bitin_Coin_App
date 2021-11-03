import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bitin_coin_app/constants/global_var.dart';
import 'package:bitin_coin_app/exception/auth_exception_handler.dart';
import 'package:bitin_coin_app/model/bitin_model.dart';
import 'package:bitin_coin_app/model/exception_data.dart';
import 'package:bitin_coin_app/services/auth.dart';
import 'package:bitin_coin_app/services/firebase_database.dart';
import 'package:bitin_coin_app/services/theme_provider.dart';
import 'package:bitin_coin_app/widgets/square_loading.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _refersController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

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
    return isLoading
        ? const Scaffold(
            body: SquareLoading(),
          )
        : Scaffold(
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
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          if (isDark) {
                            prefs.setBool('isTaskDark', false);
                            _theme.setTheme(ThemeData.light());
                          } else {
                            prefs.setBool('isTaskDark', true);
                            _theme.setTheme(ThemeData.dark());
                          }
                          setState(() {});
                        },
                        child: isDark
                            ? const Icon(Icons.light_mode_outlined, size: 50)
                            : const Icon(
                                Icons.dark_mode_outlined,
                                size: 50,
                              ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          hintText: 'Username',
                          prefixIcon: const Icon(Icons.account_circle_outlined),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: isDark ? Colors.white : Colors.black),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: isDark ? Colors.white : Colors.black),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: isDark ? Colors.white : Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: isDark ? Colors.white : Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: const Icon(Icons.mail_outline_outlined),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: isDark ? Colors.white : Colors.black),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: isDark ? Colors.white : Colors.black),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: isDark ? Colors.white : Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: isDark ? Colors.white : Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _refersController,
                        decoration: InputDecoration(
                          hintText: 'Refer Username',
                          prefixIcon: const Icon(Icons.attribution_outlined),
                          suffixIcon: const Tooltip(
                            showDuration: Duration(seconds: 5),
                            message:
                                'Enter the Username of person who referred you (*Optional)',
                            child: Icon(Icons.info_outlined),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: isDark ? Colors.white : Colors.black),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: isDark ? Colors.white : Colors.black),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: isDark ? Colors.white : Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: isDark ? Colors.white : Colors.black),
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
                              _isObscure
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: isDark ? Colors.white : Colors.black),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: isDark ? Colors.white : Colors.black),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: isDark ? Colors.white : Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: isDark ? Colors.white : Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordConfirmController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          prefixIcon: const Icon(Icons.lock),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: isDark ? Colors.white : Colors.black),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: isDark ? Colors.white : Colors.black),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: isDark ? Colors.white : Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: isDark ? Colors.white : Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      RaisedButton(
                        child: const Text('Create Account',
                            style: TextStyle(fontSize: 15)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.lightBlueAccent,
                        onPressed: () async {
                          AuthResultStatus res = AuthResultStatus.undefined;
                          if (!DatabaseService().isUserExists(
                              _usernameController.text,
                              _emailController.text)) {
                            if (_refersController.text != "" && await DatabaseService().checkForReferUser(_refersController.text)) {
                              print('1.............................................');
                              res = await AuthService().createAccount(
                                  email: _emailController.text,
                                  password: _passwordController.text);
                            } else if (_refersController.text == "") {
                              print(
                                  '2.............................................');
                              res = await AuthService().createAccount(
                                  email: _emailController.text,
                                  password: _passwordController.text);
                            } else {
                              print('****************************************');
                              if (DatabaseService().doesUsernameExists(
                                  _usernameController.text)) {
                                Get.snackbar(
                                  'Warning!',
                                  'User Already Exists',
                                  duration: const Duration(seconds: 7),
                                  animationDuration: const Duration(seconds: 2),
                                  onTap: null,
                                  snackPosition: SnackPosition.TOP,
                                );
                              } else if (DatabaseService()
                                  .doesEmailExists(_emailController.text)) {
                                res = AuthResultStatus.emailAlreadyExists;
                              } else {
                                Get.snackbar(
                                  'Warning!',
                                  'Refer is Invalid',
                                  duration: const Duration(seconds: 7),
                                  animationDuration: const Duration(seconds: 2),
                                  onTap: null,
                                  snackPosition: SnackPosition.TOP,
                                );
                                _refersController.clear();
                              }
                            }
                          }

                          else if (DatabaseService()
                              .doesUsernameExists(_usernameController.text)) {
                            print('User Already Exists');
                            Get.snackbar(
                              'Warning!',
                              'User Already Exists',
                              duration: const Duration(seconds: 7),
                              animationDuration: const Duration(seconds: 2),
                              onTap: null,
                              snackPosition: SnackPosition.TOP,
                            );
                          }

                          else if (_emailController.text.isEmpty) {
                            print('email is empty');
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
                            print('pass is empty');
                            Get.snackbar(
                              'Warning!',
                              'Password field is empty!!!',
                              duration: const Duration(seconds: 10),
                              animationDuration: const Duration(seconds: 3),
                              onTap: null,
                              snackPosition: SnackPosition.TOP,
                            );
                          } 
                          else if (_passwordController.text !=
                              _passwordConfirmController.text) {
                                print('pass is not equal to confirm pass');
                            Get.snackbar(
                              'Warning!',
                              'Incorrect Confirm Password!!!',
                              duration: const Duration(seconds: 10),
                              animationDuration: const Duration(seconds: 3),
                              onTap: null,
                              snackPosition: SnackPosition.TOP,
                            );
                          } 
                          else if (_usernameController.text ==
                              _refersController.text) {
                                print('refer is not equal to username');
                            Get.snackbar(
                              'Warning!',
                              'You can\'t refer yourself',
                              duration: const Duration(seconds: 7),
                              animationDuration: const Duration(seconds: 2),
                              onTap: null,
                              snackPosition: SnackPosition.TOP,
                            );
                          } 
                          if (res == AuthResultStatus.successful) {
                            print('success');
                            clientEmail = _emailController.text;
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString(
                                'clientEmail', _emailController.text);
                            prefs.setString(
                                'clientUsername', _usernameController.text);
                            if (!DatabaseService().isUserExists(
                                _usernameController.text,
                                _emailController.text)) {
                              if (_refersController.text != "" &&
                                  await DatabaseService().checkForReferUser(
                                      _refersController.text)) {
                                await DatabaseService().addUser(
                                    uid: clientEmail,
                                    userModel: UserModel(
                                      userName: _usernameController.text,
                                      userCoins: '0.0',
                                      userRefers: '0',
                                      userCoinMiningRate: '0.1',
                                      userIsActive: false,
                                      clickTime: DateTime.now(),
                                      userIsMining: false,
                                    ));
                                await DatabaseService().setNewUser(
                                    _usernameController.text,
                                    _emailController.text,
                                    referUsername: _refersController.text);
                                _emailController.clear();
                                _passwordController.clear();
                                _refersController.clear();
                                _usernameController.clear();
                                _passwordConfirmController.clear();
                                Navigator.pop(context);
                              } else if (_refersController.text == "") {
                                await DatabaseService().addUser(
                                    uid: clientEmail,
                                    userModel: UserModel(
                                      userName: _usernameController.text,
                                      userCoins: '0.0',
                                      userRefers: '0',
                                      userCoinMiningRate: '0.1',
                                      userIsActive: false,
                                      clickTime: DateTime.now(),
                                      userIsMining: false,
                                    ));
                                await DatabaseService().setNewUser(
                                    _usernameController.text,
                                    _emailController.text,
                                    referUsername: _refersController.text);
                                _emailController.clear();
                                _passwordController.clear();
                                _refersController.clear();
                                _usernameController.clear();
                                _passwordConfirmController.clear();
                                Navigator.pop(context);
                              } else {
                                print('refer is invalid');
                                Get.snackbar(
                                  'Warning!',
                                  'ReferUsername is Invalid',
                                  duration: const Duration(seconds: 7),
                                  animationDuration: const Duration(seconds: 2),
                                  onTap: null,
                                  snackPosition: SnackPosition.TOP,
                                );
                              }
                            } else {
                              print('Warning 1...............');
                              Get.snackbar(
                                'Warning!',
                                AuthExceptionHandler.generateExceptionMessage(
                                    res),
                                duration: const Duration(seconds: 7),
                                animationDuration: const Duration(seconds: 2),
                                onTap: null,
                                snackPosition: SnackPosition.TOP,
                              );
                              _emailController.clear();
                              _passwordController.clear();
                              _refersController.clear();
                              _usernameController.clear();
                              _passwordConfirmController.clear();
                            }
                          } 
                          else {
                            print('Warning 2.................');
                            Get.snackbar(
                              'Warning!',
                              AuthExceptionHandler.generateExceptionMessage(
                                  res),
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
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Already have an Account? ',
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                          TextSpan(
                              text: 'Sign In',
                              style: const TextStyle(
                                color: Colors.blue,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pop(context);
                                }),
                        ]),
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
