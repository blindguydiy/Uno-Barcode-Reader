/*
MIT License

Copyright (c) 2021 Hendrik Lubbe

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

//import pages
import 'createPdfTemplet.dart';
import 'productsPage.dart';

//import packages
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/product.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'dart:collection';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:io';

class editItem extends StatefulWidget {
 
  editItem({Key key, this.indexCode, this.productName, this.Index, this.barcodeType}) : super(key: key);

  String indexCode;
  String productName;
  var Index;
  String barcodeType;

  @override
  _editItemState createState() => _editItemState();
}

class _editItemState extends State<editItem> {

  FlutterTts flutterTts = new FlutterTts();
  String codeDialog;
  String valueText;
  String indexCode;
  String barcodeType;
  String productName;
  var tp;

  @override
  Widget build(BuildContext context) {
    indexCode = widget.indexCode;
    barcodeType = widget.barcodeType;
    productName = widget.productName;
    return Scaffold(

      appBar: AppBar(
        title: Text('Edit, Delete or print Item'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Text('Barcode:  ${widget.indexCode} BarCode Type: ${widget.barcodeType}'),
              ), // container
            ), // expanded
            Expanded(
              child: Container(
                child: TextFormField(
                  initialValue: '${widget.productName}',
                  enableInteractiveSelection: true,
                  onChanged: (value) {
                    setState(() {
                      valueText = value;
                    }); // setstate
                  }, // onChange
                ), // textFormField
              ), // container
            ), // expanded
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget> [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      FloatingActionButton.extended(
                        tooltip: 'Cancel and go back to product list screen',
                        label: Text('CANCEL'),
                        heroTag: 'btn1',
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        }, // onPress
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ), // floating action button extended
                      FloatingActionButton.extended(
                        tooltip: 'Save item to device',
                        label: Text('SAVE'),
                        heroTag: 'btn2',
                        onPressed: () {
                          setState(() {
                            codeDialog = valueText;
                            saveHive(widget.indexCode, codeDialog, widget.indexCode, widget.barcodeType);
                            unFocus();
                            Navigator.of(context, rootNavigator: true).pop();
                          }); // setstate
                        }, // on press
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ), // floating action button extended
                      FloatingActionButton.extended(
                        tooltip: 'Search the web for the product with the barcode detected',
                        label: Text('SEARCH WEB'),
                        heroTag: 'btn3',
                        onPressed: () {
                          setState(() {
                            searchWeb();
                          }); // setstate
                        }, // on press
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ), // floating action button extended
                    ] // row widget
                  ), // row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: FloatingActionButton.extended(
                          tooltip: 'Delete item from device',
                          label: Text('DELETE ITEM'),
                          heroTag: 'btn4',
                          onPressed: () {
                            setState(() {
                              deleteItem(widget.Index);
                              Navigator.of(context, rootNavigator: true).pop();
                            }); // setstate
                          }, // on press
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ), // floating action button extended
                      ), // expanded
                      Expanded(
                        child: FloatingActionButton.extended(
                          tooltip: 'Delete all items from device',
                          label: Text('CLEAR LIST'),
                          heroTag: 'btn5',
                          onPressed: () {
                            setState(() {
                              clearList();
                              Navigator.of(context, rootNavigator: true).pop();
                            }); // setstate
                          }, // on press
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ), // floating action button extended
                      ), // expanded
                      Expanded(
                        child: FloatingActionButton.extended(
                          tooltip: 'Generate pdf templet to print on',
                          label: Text('GENERATE PDF				'),
                          heroTag: 'btn6',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>                             createPdf(indexCode: indexCode, barcodeType: barcodeType, productName: productName)),
                          );
                          }, // on press
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ), // floating action button extended
                      ), // expanded
                    ] // row widget
                  ), //row
                ] // column widget
              ), //column
            ), // container
          ] //column widget
        ), // column
      ), // body container
    ); // scaffold 
  } // build widget

  void saveHive(String bar_code, String item_name, String bCode, String bcType) async {
    var box = Hive.box<Product>('products');
    box.put(bar_code, Product(item_name, bCode, bcType));
  }

  void deleteItem(Bcode) async {
    var box = Hive.box<Product>('products');
    box.deleteAt(Bcode);
  }

  void searchWeb() async {
    //const url = https://www.google.com/search?q=query+goes+here
    var url = 'https://www.bing.com/search?q="barcode: ${widget.indexCode}"';
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  void unFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void clearList() async {
    var box = Hive.box<Product>('products');
    box.clear();
  }
}