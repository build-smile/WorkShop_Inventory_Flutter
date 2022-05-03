import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inventory_workshop/components/stockForm.dart';
import 'package:inventory_workshop/networks/inventoryAPI.dart';

import '../models/stock.dart';
import '../utils/snackbar.dart';

class EditForm extends StatefulWidget {
  const EditForm({Key? key}) : super(key: key);

  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  InventoryAPI inventoryAPI = InventoryAPI();
  @override
  Widget build(BuildContext context) {
    Stock stock = ModalRoute.of(context)!.settings.arguments as Stock;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Stock'),
      ),
      body: Column(
        children: [
          StockForm(
            stock: stock,
            submit: _submit,
          ),
          ListTile(
            title: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red),
              onPressed: () => delete(stock.id),
              child: Text('Delete'),
            ),
          )
        ],
      ),
    );
  }

  _submit(Stock stock) async {
    EasyLoading.show(status: 'loading...');
    Stock? res = await inventoryAPI.updateStock(stock: stock);
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

  delete(int? id) async {
    InventoryAPI inventoryAPI = InventoryAPI();
    String? msg = await inventoryAPI.deleteStock(id: id!);
    SnackBarHelper.show(context: context, msg: msg!);
    Navigator.pop(context);
  }
}
