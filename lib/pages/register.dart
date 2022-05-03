import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inventory_workshop/components/userForm.dart';
import 'package:inventory_workshop/networks/userAPI.dart';
import 'package:inventory_workshop/utils/snackbar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Container(
        child: UserForm(submit: register),
      ),
    );
  }

  register(String username, String password) async {
    EasyLoading.show(status: 'loading...');
    UserAPI userAPI = UserAPI();
    String msg = await userAPI.register(username: username, password: password);
    EasyLoading.dismiss();
    SnackBarHelper.show(context: context, msg: msg);
    Navigator.pop(context);
  }
}
