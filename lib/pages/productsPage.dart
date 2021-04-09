//import pages
import 'editPage.dart';
import 'addItem.dart';

//import packages
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../model/product.dart';
import 'package:url_launcher/url_launcher.dart';

class productList extends StatefulWidget {
  productList({Key key,}) : super(key: key);

  @override
  _productListState createState() => _productListState();
}

class _productListState extends State<productList> {

  String codeDialog;
  String valueText;
  var indexCode;
  String productName;
  var Index;
  var barcodeType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products List'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _buildListView()
          ), // expanded
        ], // column widget
      ), // body column
    ); // scaffold
  }  // widget build

  Widget _buildListView() {
    return ValueListenableBuilder(
      valueListenable: Hive.box<Product>('products').listenable(),
      builder: (context, Box<Product> box, _) {
        if (box.values.isEmpty) {
          return Text('data is empty');
        } else {
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              var product = box.getAt(index);
              return ListTile(
                title: Text(product.itemName),
                onTap: () { 
                  Index = index;
                  indexCode = product.barCode;
                  productName = product.itemName;
                  barcodeType = product.bcType;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>                             editItem(indexCode: indexCode, productName: productName, Index: Index, barcodeType: barcodeType)),
                  );
                } // on tap
              ); // return listile
            }, // item builder
          );
        }
      }, // builder
    ); // return ValueListenableBuilder
  }

}
