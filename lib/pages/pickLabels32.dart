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
import 'productsPage.dart';
import 'generateBCode.dart';
import 'home.dart';

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

class pickLabels32 extends StatefulWidget {
 
  pickLabels32({Key key, this.productName, this.indexCode, this.barcodeType, }) : super(key: key);

  String productName;
  String indexCode;
  String barcodeType;
  
  @override
  _pickLabels32State createState() => _pickLabels32State();
}

class _pickLabels32State extends State<pickLabels32> {

  FlutterTts flutterTts = new FlutterTts();
  String codeDialog;
  String valueText;
  String nameText;
  String barcodeType = '23456*';
  String lbNumber;
  String labelNumber;
  String labelNumberText;
  var lbList = [];
  var lbContainer;
  var labelPick;
  String pName;
  bool _labelVal1 = false;
  bool _labelVal2 = false;
  bool _labelVal3 = false;
  bool _labelVal4 = false;
  bool _labelVal5 = false;
  bool _labelVal6 = false;
  bool _labelVal7 = false;
  bool _labelVal8 = false;
  bool _labelVal9 = false;
  bool _labelVal10 = false;
  bool _labelVal11 = false;
  bool _labelVal12 = false;
  bool _labelVal13 = false;
  bool _labelVal14 = false;
  bool _labelVal15 = false;
  bool _labelVal16 = false;
  bool _labelVal17 = false;
  bool _labelVal18 = false;
  bool _labelVal19 = false;
  bool _labelVal20 = false;
  bool _labelVal21 = false;
  bool _labelVal22 = false;
  bool _labelVal23 = false;
  bool _labelVal24 = false;
  bool _labelVal25 = false;
  bool _labelVal26 = false;
  bool _labelVal27 = false;
  bool _labelVal28 = false;
  bool _labelVal29 = false;
  bool _labelVal30 = false;
  bool _labelVal31 = false;
  bool _labelVal32 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Pick labels to print'),
        actions: [
          IconButton(
            icon: Icon( Icons.share ),
            tooltip: 'Share, Use to create pdf and export it with your app of choise to print the barcode labels that was picked',
            onPressed: () { 
              _generatePdf32();
              flutterTts.speak('Creating pdf for printing');
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => homePage(),), (route) => route.isFirst); 
            }, // on press
          ), // icon button
        ], // action
      ), // appbar
      body: DefaultTextStyle(
        child:  Container(
          color: Colors.black,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget> [
                  Container(
                    child: Text('Pick on which labels you would like to print your barcodes. When finished choosing which labels should be printed on use the share button above on the appBar to generate an a4 label sheet.'),
                  ), // container
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      checkbox('LABEL 1', _labelVal1),
                      checkbox('LABEL 2', _labelVal2),
                      checkbox('LABEL 3', _labelVal3),
                      checkbox('LABEL 4', _labelVal4),
                    ]  // row widget
                  ), // row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      checkbox('LABEL 5', _labelVal5),
                      checkbox('LABEL 6', _labelVal6),
                      checkbox('LABEL 7', _labelVal7),
                      checkbox('LABEL 8', _labelVal8),
                    ]  // row widget
                  ), // row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      checkbox('LABEL 9', _labelVal9),
                      checkbox('LABEL 10', _labelVal10),
                      checkbox('LABEL 11', _labelVal11),
                      checkbox('LABEL 12', _labelVal12),
                    ]  // row widget
                  ), // row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      checkbox('LABEL 13', _labelVal13),
                      checkbox('LABEL 14', _labelVal14),
                      checkbox('LABEL 15', _labelVal15),
                      checkbox('LABEL 16', _labelVal16),
                    ]  // row widget
                  ), // row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      checkbox('LABEL 17', _labelVal17),
                      checkbox('LABEL 18', _labelVal18),
                      checkbox('LABEL 19', _labelVal19),
                      checkbox('LABEL 20', _labelVal20),
                    ]  // row widget
                  ), // row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      checkbox('LABEL 21', _labelVal21),
                      checkbox('LABEL 22', _labelVal22),
                      checkbox('LABEL 23', _labelVal23),
                      checkbox('LABEL 24', _labelVal24),
                    ]  // row widget
                  ), // row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      checkbox('LABEL 25', _labelVal25),
                      checkbox('LABEL 26', _labelVal26),
                      checkbox('LABEL 27', _labelVal27),
                      checkbox('LABEL 28', _labelVal28),
                    ]  // row widget
                  ), // row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      checkbox('LABEL 29', _labelVal29),
                      checkbox('LABEL 30', _labelVal30),
                      checkbox('LABEL 31', _labelVal31),
                      checkbox('LABEL 32', _labelVal32),
                    ]  // row widget
                  ), // row
                ],  // column widget
              ), //column
            ), // padding
          ),  //singlescroll
        ), // container
        style: TextStyle(color: Colors.white),
      ), // defaulttextstyle
    ); // scaffold
  } //body widget build

  Future<Uint8List> _generatePdf32() async {
    final doc = pw.Document();
    //add page
    doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.symmetric(vertical: 22.0 * PdfPageFormat.mm, horizontal: 21.5 * PdfPageFormat.mm),
      //build
      build: (pw.Context context) {
        return pw.Column(

          children: <pw.Widget>[
            pw.Row(
              children: <pw.Widget> [
                createLabel('1'),
                createLabel('2'),
                createLabel('3'),
                createLabel('4'),
              ], // widget
            ), // row1
            pw.Row(
              children: <pw.Widget> [
                createLabel('5'),
                createLabel('6'),
                createLabel('7'),
                createLabel('8'),
              ], //widget
            ),  //row2
            pw.Row(
              children: <pw.Widget> [
                createLabel('9'),
                createLabel('10'),
                createLabel('11'),
                createLabel('12'),
              ], //widget
            ),  //row3
            pw.Row(
              children: <pw.Widget> [
                createLabel('13'),
                createLabel('14'),
                createLabel('15'),
                createLabel('16'),
              ], //widget
            ),  //row4
            pw.Row(
              children: <pw.Widget> [
                createLabel('17'),
                createLabel('18'),
                createLabel('19'),
                createLabel('20'),
              ], //widget
            ),  //row5
            pw.Row(
              children: <pw.Widget> [
                createLabel('21'),
                createLabel('22'),
                createLabel('23'),
                createLabel('24'),
              ], //widget
            ),  //row6
            pw.Row(
              children: <pw.Widget> [
                createLabel('25'),
                createLabel('26'),
                createLabel('27'),
                createLabel('28'),
              ], //widget
            ),  //row7
            pw.Row(
              children: <pw.Widget> [
                createLabel('29'),
                createLabel('30'),
                createLabel('31'),
                createLabel('32'),
              ], //widget
            ),  //row8
          ], // widget
        ); // column
      })); // Page

    await Printing.sharePdf(bytes: await doc.save(), filename: 'Generated-Barcode.pdf');
  }

  createLabel(lbNumber) {
    if (lbList.contains('${lbNumber}')){
      return pw.Container(
        width: (42.0 * PdfPageFormat.mm),
        height: (32.0 * PdfPageFormat.mm),
        child: pw.Column(
          children: <pw.Widget> [
            pw.BarcodeWidget(
              color: PdfColor.fromHex("#000000"),
              barcode: checkType(), //pw.Barcode.ean5(),
              data: '${widget.indexCode}', //"00001",
              //errorBuilder: (context, error) => Center(child: Text(error)),
              width: (31 * PdfPageFormat.mm),
              height: (13 * PdfPageFormat.mm),
            ), // barcode
          ], //pw.column widget
        ), // pw.column
      );  //container
      }
      return pw.Container(
        width: (42.0 * PdfPageFormat.mm), //label width 38.1mm
        height: (32.0 * PdfPageFormat.mm),
      ); //container      
  }

  checkType() {
    switch(widget.barcodeType) { 
      case "ean2": {  
        return pw.Barcode.ean2();
      } 
        break; 

      case "ean5": {  
        return pw.Barcode.ean5();
      } 
        break; 
     
      case "ean8": {  
        return pw.Barcode.ean8();
      } 
        break; 
     
      case "ean13": {  
        return pw.Barcode.ean13();
      } 
        break; 
     
      case "code39": {  
        return pw.Barcode.code39();
      } 
        break; 

      case "code93": {  
        return pw.Barcode.code93();
      } 
        break; 
 
      case "code128": {  
        return pw.Barcode.code128();
      } 
        break; 

      case "dataMatrix": {  
        return pw.Barcode.dataMatrix();
      } 
        break; 

      case "itf": {  
        return pw.Barcode.itf();
      } 
        break; 

      case "itf14": {  
        return pw.Barcode.itf14();
      } 
        break; 

      case "isbn": {  
        return pw.Barcode.isbn();
      } 
        break; 

      case "upcA": {  
        return pw.Barcode.upcA();
      } 
        break; 

      case "upcE": {  
        return pw.Barcode.upcE();
      } 
        break; 

      case "telepen": {  
        return pw.Barcode.telepen();
      } 
        break; 

      case "codabar": {  
        return pw.Barcode.codabar();
      } 
        break; 

      case "rm4scc": {  
        return pw.Barcode.rm4scc();
      } 
        break; 

      case "pdf417": {  
        return pw.Barcode.pdf417();
      } 
        break; 

      case "aztec": {  
        return pw.Barcode.aztec();
      } 
        break; 

      default: { print("Not supported"); } 
        break; 
    } 
  }

  Widget checkbox(String title, bool boolValue) {
    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
GestureDetector(
            //child: Text(title),
//onTap: () {
              onTap: () {
                /// manage the state of each value
                setState(() {
                  switch (title) {
                    case "LABEL 1":
                      _labelVal1 = boolValue; 
                      if (_labelVal1 == true) 
                        lbList.add('1');
                      if (_labelVal1 == false)
                        lbList.remove('1');
                      break;
                    case "LABEL 2":
                      _labelVal2 = boolValue;
                      if (_labelVal2 == true) 
                        lbList.add('2');
                      if (_labelVal2 == false)
                        lbList.remove('2');
                      break;
                    case "LABEL 3":
                      _labelVal3 = boolValue;
                      if (_labelVal3 == true) 
                        lbList.add('3');
                      if (_labelVal3 == false)
                        lbList.remove('3');
                      break;
                    case "LABEL 4":
                      _labelVal4 = boolValue;
                      if (_labelVal4 == true) 
                        lbList.add('4');
                      if (_labelVal4 == false)
                        lbList.remove('4');
                      break;
                    case "LABEL 5":
                      _labelVal5 = boolValue;
                      if (_labelVal5 == true) 
                        lbList.add('5');
                      if (_labelVal5 == false)
                        lbList.remove('5');
                      break;
                    case "LABEL 6":
                      _labelVal6 = boolValue;
                      if (_labelVal6 == true) 
                        lbList.add('6');
                      if (_labelVal6 == false)
                        lbList.remove('6');
                      break;
                    case "LABEL 7":
                      _labelVal7 = boolValue;
                      if (_labelVal7 == true) 
                        lbList.add('7');
                      if (_labelVal7 == false)
                        lbList.remove('7');
                      break;
                    case "LABEL 8":
                      _labelVal8 = boolValue;
                      if (_labelVal8 == true) 
                        lbList.add('8');
                      if (_labelVal8 == false)
                        lbList.remove('8');
                      break;
                    case "LABEL 9":
                      _labelVal9 = boolValue;
                      if (_labelVal9 == true) 
                        lbList.add('9');
                      if (_labelVal9 == false)
                        lbList.remove('9');
                      break;
                    case "LABEL 10":
                      _labelVal10 = boolValue;
                      if (_labelVal10 == true) 
                        lbList.add('10');
                      if (_labelVal10 == false)
                          lbList.remove('10');
                      break;
                    case "LABEL 11":
                      _labelVal11 = boolValue;
                      if (_labelVal11 == true) 
                        lbList.add('11');
                      if (_labelVal11 == false)
                        lbList.remove('11');
                      break;
                    case "LABEL 12":
                      _labelVal12 = boolValue;
                      if (_labelVal12 == true) 
                        lbList.add('12');
                      if (_labelVal12 == false)
                        lbList.remove('12');
                      break;
                    case "LABEL 13":
                      _labelVal13 = boolValue;
                      if (_labelVal13 == true) 
                        lbList.add('13');
                      if (_labelVal13 == false)
                        lbList.remove('13');
                      break;
                    case "LABEL 14":
                      _labelVal14 = boolValue;
                      if (_labelVal14 == true) 
                        lbList.add('14');
                      if (_labelVal14 == false)
                        lbList.remove('14');
                      break;
                    case "LABEL 15":
                      _labelVal15 = boolValue;
                      if (_labelVal15 == true) 
                        lbList.add('15');
                      if (_labelVal15 == false)
                        lbList.remove('15');
                      break;
                    case "LABEL 16":
                      _labelVal16 = boolValue;
                      if (_labelVal16 == true) 
                        lbList.add('16');
                      if (_labelVal16 == false)
                        lbList.remove('16');
                      break;
                    case "LABEL 17":
                      _labelVal17 = boolValue;
                      if (_labelVal17 == true) 
                        lbList.add('17');
                      if (_labelVal17 == false)
                        lbList.remove('17');
                      break;
                    case "LABEL 18":
                      _labelVal18 = boolValue;
                      if (_labelVal18 == true) 
                        lbList.add('18');
                      if (_labelVal18 == false)
                        lbList.remove('18');
                      break;
                    case "LABEL 19":
                      _labelVal19 = boolValue;
                      if (_labelVal19 == true) 
                        lbList.add('19');
                      if (_labelVal19 == false)
                        lbList.remove('19');
                      break;
                    case "LABEL 20":
                      _labelVal20 = boolValue;
                      if (_labelVal20 == true) 
                        lbList.add('20');
                      if (_labelVal20 == false)
                        lbList.remove('20');
                      break;
                    case "LABEL 21":
                      _labelVal21 = boolValue;
                      if (_labelVal21 == true) 
                        lbList.add('21');
                      if (_labelVal21 == false)
                        lbList.remove('21');
                      break;
                    case "LABEL 22":
                      _labelVal22 = boolValue;
                      if (_labelVal22 == true) 
                        lbList.add('22');
                      if (_labelVal22 == false)
                        lbList.remove('22');
                      break;
                    case "LABEL 23":
                      _labelVal23 = boolValue;
                      if (_labelVal23 == true) 
                        lbList.add('23');
                      if (_labelVal23 == false)
                        lbList.remove('23');
                      break;
                    case "LABEL 24":
                      _labelVal24 = boolValue;
                      if (_labelVal24 == true) 
                        lbList.add('24');
                      if (_labelVal24 == false)
                        lbList.remove('24');
                      break;
                    case "LABEL 25":
                      _labelVal25 = boolValue;
                      if (_labelVal25 == true) 
                        lbList.add('25');
                      if (_labelVal25 == false)
                        lbList.remove('25');
                      break;
                    case "LABEL 26":
                      _labelVal26 = boolValue;
                      if (_labelVal26 == true) 
                        lbList.add('26');
                      if (_labelVal26 == false)
                        lbList.remove('26');
                      break;
                    case "LABEL 27":
                      _labelVal27 = boolValue;
                      if (_labelVal27 == true) 
                        lbList.add('27');
                      if (_labelVal27 == false)
                        lbList.remove('27');
                      break;
                    case "LABEL 28":
                      _labelVal28 = boolValue;
                      if (_labelVal28 == true) 
                        lbList.add('28');
                      if (_labelVal28 == false)
                        lbList.remove('28');
                      break;
                    case "LABEL 29":
                      _labelVal29 = boolValue;
                      if (_labelVal29 == true) 
                        lbList.add('29');
                      if (_labelVal29 == false)
                        lbList.remove('29');
                      break;
                    case "LABEL 30":
                      _labelVal30 = boolValue;
                      if (_labelVal30 == true) 
                        lbList.add('30');
                      if (_labelVal30 == false)
                        lbList.remove('30');
                      break;
                    case "LABEL 31":
                      _labelVal31 = boolValue;
                      if (_labelVal31 == true) 
                        lbList.add('31');
                      if (_labelVal31 == false)
                        lbList.remove('31');
                      break;
                    case "LABEL 32":
                      _labelVal32 = boolValue;
                      if (_labelVal32 == true) 
                        lbList.add('32');
                      if (_labelVal32 == false)
                        lbList.remove('32');
                      break;
                  
                    default: { print("Invalid choice"); } 
                      break; 
                  }  // switch
                }); // setstate
              }, // on change
            child: Text(title),

            ), 
            Checkbox(
              value: boolValue,
              onChanged: (bool value) {
                /// manage the state of each value
                setState(() {
                  switch (title) {
                    case "LABEL 1":
                      _labelVal1 = value; 
                      if (_labelVal1 == true) 
                        lbList.add('1');
                      if (_labelVal1 == false)
                        lbList.remove('1');
                      break;
                    case "LABEL 2":
                      _labelVal2 = value;
                      if (_labelVal2 == true) 
                        lbList.add('2');
                      if (_labelVal2 == false)
                        lbList.remove('2');
                      break;
                    case "LABEL 3":
                      _labelVal3 = value;
                      if (_labelVal3 == true) 
                        lbList.add('3');
                      if (_labelVal3 == false)
                        lbList.remove('3');
                      break;
                    case "LABEL 4":
                      _labelVal4 = value;
                      if (_labelVal4 == true) 
                        lbList.add('4');
                      if (_labelVal4 == false)
                        lbList.remove('4');
                      break;
                    case "LABEL 5":
                      _labelVal5 = value;
                      if (_labelVal5 == true) 
                        lbList.add('5');
                      if (_labelVal5 == false)
                        lbList.remove('5');
                      break;
                    case "LABEL 6":
                      _labelVal6 = value;
                      if (_labelVal6 == true) 
                        lbList.add('6');
                      if (_labelVal6 == false)
                        lbList.remove('6');
                      break;
                    case "LABEL 7":
                      _labelVal7 = value;
                      if (_labelVal7 == true) 
                        lbList.add('7');
                      if (_labelVal7 == false)
                        lbList.remove('7');
                      break;
                    case "LABEL 8":
                      _labelVal8 = value;
                      if (_labelVal8 == true) 
                        lbList.add('8');
                      if (_labelVal8 == false)
                        lbList.remove('8');
                      break;
                    case "LABEL 9":
                      _labelVal9 = value;
                      if (_labelVal9 == true) 
                        lbList.add('9');
                      if (_labelVal9 == false)
                        lbList.remove('9');
                      break;
                    case "LABEL 10":
                      _labelVal10 = value;
                      if (_labelVal10 == true) 
                        lbList.add('10');
                      if (_labelVal10 == false)
                          lbList.remove('10');
                      break;
                    case "LABEL 11":
                      _labelVal11 = value;
                      if (_labelVal11 == true) 
                        lbList.add('11');
                      if (_labelVal11 == false)
                        lbList.remove('11');
                      break;
                    case "LABEL 12":
                      _labelVal12 = value;
                      if (_labelVal12 == true) 
                        lbList.add('12');
                      if (_labelVal12 == false)
                        lbList.remove('12');
                      break;
                    case "LABEL 13":
                      _labelVal13 = value;
                      if (_labelVal13 == true) 
                        lbList.add('13');
                      if (_labelVal13 == false)
                        lbList.remove('13');
                      break;
                    case "LABEL 14":
                      _labelVal14 = value;
                      if (_labelVal14 == true) 
                        lbList.add('14');
                      if (_labelVal14 == false)
                        lbList.remove('14');
                      break;
                    case "LABEL 15":
                      _labelVal15 = value;
                      if (_labelVal15 == true) 
                        lbList.add('15');
                      if (_labelVal15 == false)
                        lbList.remove('15');
                      break;
                    case "LABEL 16":
                      _labelVal16 = value;
                      if (_labelVal16 == true) 
                        lbList.add('16');
                      if (_labelVal16 == false)
                        lbList.remove('16');
                      break;
                    case "LABEL 17":
                      _labelVal17 = value;
                      if (_labelVal17 == true) 
                        lbList.add('17');
                      if (_labelVal17 == false)
                        lbList.remove('17');
                      break;
                    case "LABEL 18":
                      _labelVal18 = value;
                      if (_labelVal18 == true) 
                        lbList.add('18');
                      if (_labelVal18 == false)
                        lbList.remove('18');
                      break;
                    case "LABEL 19":
                      _labelVal19 = value;
                      if (_labelVal19 == true) 
                        lbList.add('19');
                      if (_labelVal19 == false)
                        lbList.remove('19');
                      break;
                    case "LABEL 20":
                      _labelVal20 = value;
                      if (_labelVal20 == true) 
                        lbList.add('20');
                      if (_labelVal20 == false)
                        lbList.remove('20');
                      break;
                    case "LABEL 21":
                      _labelVal21 = value;
                      if (_labelVal21 == true) 
                        lbList.add('21');
                      if (_labelVal21 == false)
                        lbList.remove('21');
                      break;
                    case "LABEL 22":
                      _labelVal22 = value;
                      if (_labelVal22 == true) 
                        lbList.add('22');
                      if (_labelVal22 == false)
                        lbList.remove('22');
                      break;
                    case "LABEL 23":
                      _labelVal23 = value;
                      if (_labelVal23 == true) 
                        lbList.add('23');
                      if (_labelVal23 == false)
                        lbList.remove('23');
                      break;
                    case "LABEL 24":
                      _labelVal24 = value;
                      if (_labelVal24 == true) 
                        lbList.add('24');
                      if (_labelVal24 == false)
                        lbList.remove('24');
                      break;
                    case "LABEL 25":
                      _labelVal25 = value;
                      if (_labelVal25 == true) 
                        lbList.add('25');
                      if (_labelVal25 == false)
                        lbList.remove('25');
                      break;
                    case "LABEL 26":
                      _labelVal26 = value;
                      if (_labelVal26 == true) 
                        lbList.add('26');
                      if (_labelVal26 == false)
                        lbList.remove('26');
                      break;
                    case "LABEL 27":
                      _labelVal27 = value;
                      if (_labelVal27 == true) 
                        lbList.add('27');
                      if (_labelVal27 == false)
                        lbList.remove('27');
                      break;
                    case "LABEL 28":
                      _labelVal28 = value;
                      if (_labelVal28 == true) 
                        lbList.add('28');
                      if (_labelVal28 == false)
                        lbList.remove('28');
                      break;
                    case "LABEL 29":
                      _labelVal29 = value;
                      if (_labelVal29 == true) 
                        lbList.add('29');
                      if (_labelVal29 == false)
                        lbList.remove('29');
                      break;
                    case "LABEL 30":
                      _labelVal30 = value;
                      if (_labelVal30 == true) 
                        lbList.add('30');
                      if (_labelVal30 == false)
                        lbList.remove('30');
                      break;
                    case "LABEL 31":
                      _labelVal31 = value;
                      if (_labelVal31 == true) 
                        lbList.add('31');
                      if (_labelVal31 == false)
                        lbList.remove('31');
                      break;
                    case "LABEL 32":
                      _labelVal32 = value;
                      if (_labelVal32 == true) 
                        lbList.add('32');
                      if (_labelVal32 == false)
                        lbList.remove('32');
                      break;
                  
                    default: { print("Invalid choice"); } 
                      break; 
                  }  // switch
                }); // setstate
              }, // on change
            ) // checkbox

          ], // column widget
        ), // column
      ), // container
    ); // return expanded
  }

}
/*
Information About This Label Size:
Number Across
4
Label Width
40mm
Label Height
30mm
Horizontal Pitch
42mm
Vertical Pitch
32mm
Number Down
8
Top Margin
21.5mm
Bottom Margin
21.5mm
Left Margin
22mm
Right Margin
22mm
Also Known As

*/