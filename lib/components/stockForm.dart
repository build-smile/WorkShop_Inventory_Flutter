import 'package:flutter/material.dart';
import 'package:inventory_workshop/models/stock.dart';
import 'package:inventory_workshop/networks/inventoryAPI.dart';
import 'package:inventory_workshop/utils/snackbar.dart';

class StockFormScreen extends StatefulWidget {
  final Function submit;
  final Stock stock;
  const StockFormScreen({Key? key, required this.submit, required this.stock})
      : super(key: key);

  @override
  _StockFormScreenState createState() => _StockFormScreenState();
}

class _StockFormScreenState extends State<StockFormScreen> {
  var _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // Stock? oldStock = ModalRoute.of(context)!.settings.arguments as Stock?;

    return Container(
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            ListTile(
              title: _textFormField(
                  initialValue: widget.stock.description.toString(),
                  label: 'Name',
                  onValidate: (String? value) => _validateSting(value),
                  onSave: (String? value) {
                    widget.stock.description = value;
                  }),
            ),
            ListTile(
              title: _textFormField(
                  initialValue: widget.stock.stock.toString(),
                  label: 'Stock',
                  inputType: TextInputType.number,
                  onValidate: (String? value) => _validateNumber(value),
                  onSave: (String? value) {
                    widget.stock.stock = double.parse(value!);
                  }),
            ),
            ListTile(
              title: _textFormField(
                  initialValue: widget.stock.price.toString(),
                  label: 'Price',
                  inputType: TextInputType.number,
                  onValidate: (String? value) => _validateNumber(value),
                  onSave: (String? value) {
                    widget.stock.price = double.parse(value!);
                  }),
            ),
            ListTile(
                title: ElevatedButton(
              child: Text('Submit'),
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  _formkey.currentState!.save();
                  widget.submit(widget.stock);
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

  submit(int? id) async {
    // if (_formkey.currentState!.validate()) {
    //   _formkey.currentState!.save();
    //   InventoryAPI inventoryAPI = InventoryAPI();
    //   Stock? stock;
    //   if (id == -1) {
    //     stock = await inventoryAPI.createStock(stock: newStock);
    //   } else {
    //     stock = await inventoryAPI.updateStock(stock: newStock);
    //   }
    //
    //   if (stock == null) {
    //     SnackBarHelper.show(
    //         context: context, msg: 'Something went wrong', color: Colors.red);
    //   } else {
    //     SnackBarHelper.show(
    //         context: context,
    //         msg: 'Update Stock Complete',
    //         color: Colors.green);
    //     Navigator.pop(context);
    //   }
    // }
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
