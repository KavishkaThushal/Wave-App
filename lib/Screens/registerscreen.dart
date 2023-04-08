import 'package:flutter/material.dart';
import 'package:greenchat/Screens/chatscreen.dart';
import 'package:greenchat/constants.dart';
import 'package:greenchat/components/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'register_screen';

  const RegisterScreen({super.key});
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _showSpin=false;
  final _authentication=FirebaseAuth.instance;
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
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag:'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('img/logo.png'),
                    ),
                  ),
                  const SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email=value;
                    },
                    decoration:
                        kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    obscureText: true,
                    onChanged: (value) {
                      password=value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your password'),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  RoundButton(
                    colour: Colors.blueAccent,
                    press: ()async {
                      setState(() {
                        _showSpin=true;
                      });
                      try {
                        final newUser = await _authentication
                            .createUserWithEmailAndPassword(
                            email: email, password: password);
                        if (newUser != null) {
                          Navigator.pushNamed(context, ChatScreen.id);
                        }
                        setState(() {
                          _showSpin=false;
                        });
                      }catch(e){
                        print(e);
                      }
                     },
                    name: 'Register',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
