import 'package:flutter/material.dart';
import 'package:greenchat/Screens/loginscreen.dart';
import 'package:greenchat/Screens/registerscreen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:greenchat/components/button.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = ColorTween(begin: Colors.black12, end: Colors.white)
        .animate(controller);
    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: animation.value,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 300.0,
                child: Image.asset('img/hello1.png'),
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('img/logo.png'),
                      width: 130.0,
                    ),
                  ),
                  AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Wave App',
                        textStyle: TextStyle(
                            fontSize: 38.0,
                            fontWeight: FontWeight.w900,
                            color: Colors.black54),
                        speed: Duration(milliseconds: 200),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 40.0,
              ),
              RoundButton(
                colour: Color(0xFF009FBD),
                press: () {
                  Navigator.pushNamed(context, Login.id);
                },
                name: 'Log in',
              ),
              RoundButton(
                colour: Colors.teal,
                press: () {
                  Navigator.pushNamed(context, RegisterScreen.id);
                },
                name: 'Register',
              ),
            ],
          ),
        ),
      ),
    );
  }
}


