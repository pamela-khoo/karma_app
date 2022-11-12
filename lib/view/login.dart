import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:karma_app/controller/api.dart';
import 'package:karma_app/view/bottom_view.dart';
import 'package:karma_app/view/view_home.dart';
import 'package:karma_app/widget/router.dart';
import 'package:karma_app/widget/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:karma_app/view/register.dart';
import '../main.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future login() async {
    var url = ApiConstant().baseUrl + ApiConstant().login;
    var response = await http.post(url, body: {
      "email": user.text,
      "password": pass.text,
    });

    var data = jsonDecode(response.body);

    if (data[3].toString() == "Success") {
      await FlutterSession().set('token', user.text);

      Fluttertoast.showToast(
        msg: 'Login Successful',
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
      );

      //Store data to shared preferences
      prefLogin(id: data[0], name: data[1], email: data[2]);

      pushPage(context, BottomView());
    } else {
      Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'Username and password invalid',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    prefLoad().then((value) {
      setState(() {
        if (value != null) {
          pushAndRemove(context, BottomView());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: Colors.white),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 150.0,
                  width: 150.0,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/karma_logo_2.png'),
                          fit: BoxFit.scaleDown),
                      ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: 100,
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30)
                          .copyWith(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text(
                            ' Login',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'Aleo',
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30)
                      .copyWith(bottom: 10),
                  child: TextField(
                    controller: user,
                    style: const TextStyle(color: Colors.black, fontSize: 14.5),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 238, 240, 241),
                        prefixIconConstraints:
                            const BoxConstraints(minWidth: 45),
                        prefixIcon: const Icon(
                          Icons.alternate_email_outlined,
                          color: Color.fromARGB(255, 0, 150, 136),
                          size: 22,
                        ),
                        border: InputBorder.none,
                        hintText: 'Enter Username',
                        hintStyle: const TextStyle(
                            color: Colors.black54, fontSize: 14.5),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100).copyWith(
                                bottomRight: const Radius.circular(0)),
                            borderSide:
                                const BorderSide(color:Color.fromARGB(255, 238, 240, 241))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100).copyWith(
                                bottomRight: const Radius.circular(0)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 208, 210, 211)))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30)
                      .copyWith(bottom: 10),
                  child: TextField(
                    controller: pass,
                    style: const TextStyle(color: Colors.black, fontSize: 14.5),
                    obscureText: isPasswordVisible ? false : true,
                    decoration: InputDecoration(
                      filled: true,
                        fillColor: Color.fromARGB(255, 238, 240, 241),
                        prefixIconConstraints:
                            const BoxConstraints(minWidth: 45),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.teal,
                          size: 22,
                        ),
                        suffixIconConstraints:
                            const BoxConstraints(minWidth: 45, maxWidth: 46),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          child: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Color.fromARGB(255, 61, 61, 61),
                            size: 22,
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: 'Enter Password',
                       hintStyle: const TextStyle(
                            color: Colors.black54, fontSize: 14.5),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100).copyWith(
                                bottomRight: const Radius.circular(0)),
                            borderSide:
                                const BorderSide(color:Color.fromARGB(255, 238, 240, 241))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100).copyWith(
                                bottomRight: const Radius.circular(0)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 208, 210, 211)))),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () async {
                    login();
                    prefLoad();
                  },
                  child: Container(
                    height: 53,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 4,
                              color: Colors.black12.withOpacity(.2),
                              offset: const Offset(2, 2))
                        ],
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.teal.withOpacity(.8)),
                    child: Text('Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text('Don\'t have an account?',
                    style: TextStyle(color: Color.fromARGB(255, 77, 77, 77), fontSize: 13)),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    pushAndRemove(context, Register());
                  },
                 child: Container(
                    height: 53,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 4,
                              color: Colors.black12.withOpacity(.2),
                              offset: const Offset(2, 2))
                        ],
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white.withOpacity(.8)),
                    child: Text('Sign Up',
                        style: TextStyle(
                            color: Colors.black.withOpacity(.8),
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
