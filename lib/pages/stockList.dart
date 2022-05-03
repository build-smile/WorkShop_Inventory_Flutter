import 'package:flutter/material.dart';
import 'package:inventory_workshop/networks/inventoryAPI.dart';

import '../models/stock.dart';

class StockList extends StatefulWidget {
  const StockList({Key? key}) : super(key: key);

  @override
  _StockListState createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: InventoryAPI().getAll(),
        builder: (BuildContext context, AsyncSnapshot<List<Stock?>?> snapshot) {
          if (snapshot.hasData) {
            List<Stock?> stocks = snapshot.data!;
            return ListView.builder(
              itemCount: stocks.length,
              itemBuilder: (context, index) {
                Stock? stock = stocks[index];
                return ListTile(
                  title: Text('${stock!.description}'),
                  subtitle: Text('Stock: ${stock.stock}'),
                  trailing: Text('${stock.price} baht'),
                  onTap: () {
                    Navigator.pushNamed(context, '/editForm', arguments: stock)
                        .then((value) => {setState(() {})});
                  },
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addForm')
              .then((value) => {setState(() {})});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
