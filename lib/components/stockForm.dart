import 'package:flutter/material.dart';
import 'package:inventory_workshop/models/stock.dart';

class StockForm extends StatelessWidget {
  final Function submit;
  final Stock stock;
  const StockForm({Key? key, required this.submit, required this.stock})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _formkey = GlobalKey<FormState>();
    return Container(
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            ListTile(
              title: _textFormField(
                  initialValue: stock.description.toString(),
                  label: 'Name',
                  onValidate: (String? value) => _validateSting(value),
                  onSave: (String? value) {
                    stock.description = value;
                  }),
            ),
            ListTile(
              title: _textFormField(
                  initialValue: stock.stock.toString(),
                  label: 'Stock',
                  inputType: TextInputType.number,
                  onValidate: (String? value) => _validateNumber(value),
                  onSave: (String? value) {
                    stock.stock = double.parse(value!);
                  }),
            ),
            ListTile(
              title: _textFormField(
                  initialValue: stock.price.toString(),
                  label: 'Price',
                  inputType: TextInputType.number,
                  onValidate: (String? value) => _validateNumber(value),
                  onSave: (String? value) {
                    stock.price = double.parse(value!);
                  }),
            ),
            ListTile(
                title: ElevatedButton(
              child: Text('Submit'),
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  _formkey.currentState!.save();
                  submit(stock);
                }
              },
            )),
          ],
        ),
      ),
    );
  }

  Widget _textFormField(
      {required String label,
      required Function onSave,
      required Function onValidate,
      required String initialValue,
      TextInputType inputType = TextInputType.text}) {
    return TextFormField(
      initialValue: initialValue,
      keyboardType: inputType,
      onSaved: (String? value) => onSave(value),
      validator: (String? value) => onValidate(value),
      decoration: InputDecoration(labelText: label, hintText: label),
    );
  }

  String? _validateSting(String? value) {
    if (value == null || value == '') {
      return 'Please fill data';
    }
    return null;
  }

  String? _validateNumber(String? value) {
    if (value == null || value == '') {
      return 'Please fill data';
    }
    if (double.tryParse(value) == null) {
      return 'Invalid number';
    }
    return null;
  }
}
