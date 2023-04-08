import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greenchat/Screens/chatscreen.dart';
import 'package:greenchat/components/button.dart';
import 'package:greenchat/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Login extends StatefulWidget {
  static const String id = 'login_screen';
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _showSpin = false;
  final _authentication = FirebaseAuth.instance;
  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: _showSpin,
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('img/back.png'),
              repeat: ImageRepeat.repeatY,
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('img/logo.png'),
                  ),
                ),
                const SizedBox(
                  height: 48.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  child: TextField(
                    onChanged: (value) {
                      email = value;
                    },
                    decoration:
                        kTextFieldDecoration.copyWith(hintText: 'Enter Email'),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your password.'),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),

                RoundButton(
                  colour: const Color(0xFF009FBD),
                  press: () async {
                    setState(() {
                      _showSpin = true;
                    });
                    try {
                      final user =
                          await _authentication.signInWithEmailAndPassword(
                              email: email, password: password);
                      if (user != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                      setState(() {
                        _showSpin = false;
                      });
                    } catch (e) {
                       print(e);
                    }
                  },
                  name: 'Log In',
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
