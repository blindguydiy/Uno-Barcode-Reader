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

// import pages
import 'pickLabels.dart';

// import packages
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

class newGen extends StatefulWidget {
 
  newGen({Key key, }) : super(key: key);

  @override
  _newGenState createState() => _newGenState();
}

class _newGenState extends State<newGen> {

  FlutterTts flutterTts = new FlutterTts();
  String codeDialog;
  String valueText;
  String nameText;
  String productName;
  String indexCode;
  String barcodeType = 'code39';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Generate new product barcode'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Text('Create a new barcode for an item to be identified.  Enter the item name and a 4 digit code for a barcode.'),
              ), // container
              Container(
                child: TextFormField(                
                  decoration: InputDecoration(
                    labelText: 'Item Name',
                  ), // decoration
                  enableInteractiveSelection: true,
                  onChanged: (value) {
                    setState(() {
                      nameText = value;
                    }); // setstate
                  }, // onChange
                ), // textFormField
              ), // container
              Container(
                child: TextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(4),
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter a 4 digit barcode',
                  ), //                 decoration
                  enableInteractiveSelection: true,
                  onChanged: (value) {
                    setState(() {
                      valueText = value;
                    }); // setstate
                  }, // onChange
                ), // textFormField
              ), // container
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //Cancel button
                    FloatingActionButton.extended(
                      tooltip: 'Cancel and go back to home screen',
                      label: Text('CANCEL'),
                      heroTag: 'btn1',
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      }, // onPress
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ), // floating action button extended
                    //save button
                    FloatingActionButton.extended(
                      tooltip: 'Save item to device',
                      label: Text('SAVE'),
                      heroTag: 'btn2',
                      onPressed: () {
                        setState(() {
                          productName = nameText;
                          indexCode = valueText;
                          productName == null ? flutterTts.speak('Enter Name') : productName.length < 1 ? flutterTts.speak('Enter Name') : indexCode == null ? flutterTts.speak('Enter a 4 digit code') : indexCode.length != 4 ? flutterTts.speak('Enter 5 digits') : saveHive(indexCode, productName, indexCode, barcodeType);
                          unFocus();
                          Navigator.of(context, rootNavigator: true).pop();
                        }); // setstate
                      }, // onPress
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ), // floating action button extended
                    //choose labels and generate pdf
                    FloatingActionButton.extended(
                      tooltip: 'Pick labels to print',
                      label: Text('PICK LABELS'),
                      heroTag: 'btn3',
                      onPressed: () {
                        productName = nameText;
                        indexCode = valueText;
                        productName == null ? flutterTts.speak('Enter Name') : productName.length < 1 ? flutterTts.speak('Enter Name') : indexCode == null ? flutterTts.speak('Enter a 4 digit code') : indexCode.length != 4 ? flutterTts.speak('Enter 5 digits') : Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>                             pickLabels(productName: productName, indexCode: indexCode, barcodeType: barcodeType)),
                          );
                        saveHive(indexCode, productName, indexCode, barcodeType);
                      }, // on press
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ), // floating action button extended
                  ] // row widget
                ), // row
              ), // container
            ] // column
          ), // column
        ), // center
      ), // body container
    );  // scaffold
  } // build widget

  void saveHive(String bar_code, String item_name, String bCode, String bcType) async {
    var box = Hive.box<Product>('products');
    box.put(bar_code, Product(item_name, bCode, bcType));
  }

  void unFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

}