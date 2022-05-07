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
              title: TextFormField(
                  initialValue: stock.description.toString(),
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: _validateSting,
                  onSaved: (String? value) {
                    stock.description = value;
                  }),
            ),
            ListTile(
              title: TextFormField(
                  initialValue: stock.stock.toString(),
                  decoration: InputDecoration(
                    labelText: 'Stock',
                  ),
                  keyboardType: TextInputType.number,
                  validator: _validateNumber,
                  onSaved: (String? value) {
                    stock.stock = double.parse(value!);
                  }),
            ),
            ListTile(
              title: TextFormField(
                  initialValue: stock.price.toString(),
                  decoration: InputDecoration(
                    labelText: 'Price',
                  ),
                  keyboardType: TextInputType.number,
                  validator: _validateNumber,
                  onSaved: (String? value) {
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
