import 'package:flutter/material.dart';
import 'package:greenchat/components/button.dart';
import 'package:greenchat/constants.dart';

class Login extends StatefulWidget {
  static const String id = 'login_screen';
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('img/back.png'),
              repeat: ImageRepeat.repeatY,
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'logo',
                child: Container(
                  height: 250.0,
                  child: Image.asset('img/logo.png'),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: TextField(
                  onChanged: (value) {},
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'Enter Email'),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                child: TextField(
                  onChanged: (value) {
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password.'),
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundButton(
                colour: Color(0xFF009FBD),
                press: () {
                  //Implement registration functionality.
                },
                name: 'Log In',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
