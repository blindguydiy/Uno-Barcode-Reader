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
import 'scanner.dart';
import 'productsPage.dart';

//import packages
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

class adItem extends StatefulWidget {
 
  adItem({Key key,this.ite, this.barcodeType,}) : super(key: key);
  var ite;
  String barcodeType;

  @override
  _adItemState createState() => _adItemState();
}

class _adItemState extends State<adItem> {

  FlutterTts flutterTts = new FlutterTts();
  String codeDialog;
  String valueText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Add Item'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Text('Barcode:  ${widget.ite} Barcode Type: ${widget.barcodeType}'),
              ), // container
            ), // expanded
            Expanded(
              child: Container(
                child: TextFormField(                
                  decoration: InputDecoration(
                    labelText: 'Item Name',
                  ), // decoration
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: FloatingActionButton.extended(
                      tooltip: 'Cancel and go back to scanning screen',
                      label: Text('CANCEL'),
                      heroTag: 'btn1',
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => scanner(),), (route) => route.isFirst); 
                      }, // onPress
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ), // floating action button extended
                  ), // expanded
                  Expanded(
                    child: FloatingActionButton.extended(
                      tooltip: 'Save item to device',
                      label: Text('SAVE'),
                      heroTag: 'btn2',
                      onPressed: () {
                        setState(() {
                          codeDialog = valueText;
                          saveHive(widget.ite, codeDialog, widget.ite, widget.barcodeType);
                          unFocus();
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => scanner(),), (route) => route.isFirst);
                        }); // setstate
                      }, // onPress
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ), // floating action button extended
                  ), // expanded
                  Expanded(
                    child: FloatingActionButton.extended(
                      tooltip: 'Search the web for the product with the barcode detected',
                      label: Text('SEARCH WEB'),
                      heroTag: 'btn3',
                      onPressed: () {
                        setState(() {
                          searchWeb();
                        }); // setstate
                      }, // onPress
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ), // floating action button extended
                  ), // expanded
                ] // row widget
              ), // row
            ), // container
          ] // column widget
        ), // column
      ), // body container
    ); //scaffold
  }  // build widget

  void saveHive(String bar_code, String item_name, String bCode, String brcType) async {
    var box = Hive.box<Product>('products');
    box.put(bar_code, Product(item_name, bCode, brcType));
  }

  void searchWeb() async {
    //const url = https://www.google.com/search?q=query+goes+here
    var url = 'https://www.bing.com/search?q="barcode: ${widget.ite}"';
    //var url = 'https://api.barcodelookup.com/v2/products?barcode=${widget.ite}&formatted=y&key=ifDzhmKslKav42OD93NE'; 

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

}