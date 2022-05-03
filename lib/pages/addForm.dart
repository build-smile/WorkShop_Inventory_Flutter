import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inventory_workshop/components/stockForm.dart';
import '../models/stock.dart';
import '../networks/inventoryAPI.dart';
import '../utils/snackbar.dart';

class AddForm extends StatefulWidget {
  const AddForm({Key? key}) : super(key: key);

  @override
  _AddFormState createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  Stock stock = Stock();
  InventoryAPI inventoryAPI = InventoryAPI();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Stock'),
      ),
      body: StockForm(submit: _submit, stock: stock),
    );
  }

  _submit(Stock stock) async {
    EasyLoading.show(status: 'loading...');
    Stock? res = await inventoryAPI.createStock(stock: stock);
    EasyLoading.dismiss();
    if (res == null) {
      SnackBarHelper.show(
          context: context, msg: 'Something went wrong', color: Colors.red);
    } else {
      SnackBarHelper.show(
          context: context, msg: 'Update Stock Complete', color: Colors.green);
      Navigator.pop(context);
    }
  }
}
