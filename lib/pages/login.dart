import 'package:flutter/material.dart';
import 'package:inventory_workshop/components/userForm.dart';
import 'package:inventory_workshop/models/login.dart';
import 'package:inventory_workshop/networks/userAPI.dart';
import 'package:inventory_workshop/utils/snackbar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(50),
            child: FlutterLogo(),
            width: 150,
            height: 150,
          ),
          SizedBox(
            height: 10,
          ),
          UserForm(submit: login),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/register'),
            child: Text('Need an Account'),
          )
        ],
      )),
    );
  }

  login(String username, String password) async {
    UserAPI userAPI = UserAPI();
    EasyLoading.show(status: 'loading...');
    Login? login = await userAPI.login(username: username, password: password);
    if (login == null) {
      SnackBarHelper.show(
          context: context, msg: 'Invalid user', color: Colors.red);
      EasyLoading.dismiss();
      return;
    }
    userAPI.storeToken(token: login.accessToken);
    EasyLoading.dismiss();
    SnackBarHelper.show(
        context: context, msg: 'Welcome to Inventory', color: Colors.green);
    Navigator.pushNamed(context, '/home');
  }
}
