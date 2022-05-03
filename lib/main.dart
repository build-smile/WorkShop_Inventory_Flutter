import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inventory_workshop/networks/userAPI.dart';
import 'package:inventory_workshop/pages/addForm.dart';
import 'package:inventory_workshop/pages/editForm.dart';
import 'package:inventory_workshop/pages/home.dart';
import 'package:inventory_workshop/pages/login.dart';
import 'package:inventory_workshop/pages/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/addForm': (context) => const AddForm(),
        '/login': (context) => const LoginScreen(),
        '/editForm': (context) => const EditForm()
      },
      theme: ThemeData(
          textTheme: const TextTheme(
              headline1: TextStyle(
                  fontSize: 25,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold))),
      home: FutureBuilder(
          future: UserAPI().getToken(),
          builder:
              (BuildContext buildContext, AsyncSnapshot<String?> snapshot) {
            if (snapshot.hasData) {
              return const HomeScreen();
            }
            return const LoginScreen();
          }),
      builder: EasyLoading.init(),
    );
  }
}
