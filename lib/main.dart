import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:greenchat/Screens/chatscreen.dart';
import 'package:greenchat/Screens/homescreen.dart';
import 'package:greenchat/Screens/loginscreen.dart';
import 'package:greenchat/Screens/registerscreen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData.dark(),
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => const HomeScreen(),
        Login.id: (context) => const Login(),
        RegisterScreen.id: (context) => RegisterScreen(),
        ChatScreen.id: (context) => const ChatScreen(),
      },
    );
  }
}
