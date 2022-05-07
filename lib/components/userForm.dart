import 'package:flutter/material.dart';

class UserForm extends StatelessWidget {
  final Function submit;
  const UserForm({Key? key, required this.submit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _keyForm = GlobalKey<FormState>();
    String username = '';
    String password = '';
    return Form(
      key: _keyForm,
      child: Column(
        children: [
          ListTile(
            title: TextFormField(
              validator: _validateSting,
              onSaved: (String? value) {
                username = value!;
              },
              decoration:
                  InputDecoration(labelText: 'Username', hintText: 'Username'),
            ),
          ),
          ListTile(
            title: TextFormField(
              obscureText: true,
              validator: _validateSting,
              onSaved: (String? value) {
                password = value!;
              },
              decoration:
                  InputDecoration(labelText: 'Password', hintText: 'Password'),
            ),
          ),
          ListTile(
            title: ElevatedButton(
              child: Text('Login'),
              onPressed: () {
                if (_keyForm.currentState!.validate()) {
                  _keyForm.currentState!.save();
                  submit(username, password);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  String? _validateSting(String? value) {
    if (value == null || value == '') {
      return 'Please fill data';
    }
    return null;
  }
}
