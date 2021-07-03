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

class pickLabels65 extends StatefulWidget {
 
  pickLabels65({Key key, this.productName, this.indexCode, this.barcodeType, }) : super(key: key);

  String productName;
  String indexCode;
  String barcodeType;
  
  @override
  _pickLabels65State createState() => _pickLabels65State();
}

class _pickLabels65State extends State<pickLabels65> {

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
  bool _labelVal33 = false;
  bool _labelVal34 = false;
  bool _labelVal35 = false;
  bool _labelVal36 = false;
  bool _labelVal37 = false;
  bool _labelVal38 = false;
  bool _labelVal39 = false;
  bool _labelVal40 = false;
  bool _labelVal41 = false;
  bool _labelVal42 = false;
  bool _labelVal43 = false;
  bool _labelVal44 = false;
  bool _labelVal45 = false;
  bool _labelVal46 = false;
  bool _labelVal47 = false;
  bool _labelVal48 = false;
  bool _labelVal49 = false;
  bool _labelVal50 = false;
  bool _labelVal51 = false;
  bool _labelVal52 = false;
  bool _labelVal53 = false;
  bool _labelVal54 = false;
  bool _labelVal55 = false;
  bool _labelVal56 = false;
  bool _labelVal57 = false;
  bool _labelVal58 = false;
  bool _labelVal59 = false;
  bool _labelVal60 = false;
  bool _labelVal61 = false;
  bool _labelVal62 = false;
  bool _labelVal63 = false;
  bool _labelVal64 = false;
  bool _labelVal65 = false;

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
              _generatePdf65();
              flutterTts.speak('Creating pdf for printing');
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => homePage(),), (route) => route.isFirst); 
            }, // on press
          ), // icon button
        ], // action
      ), // appbar
      body: DefaultTextStyle(
        child: Container(
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
                      checkbox('LABEL 5', _labelVal5),
                    ]  // row widget
                  ), // row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      checkbox('LABEL 6', _labelVal6),
                      checkbox('LABEL 7', _labelVal7),
                      checkbox('LABEL 8', _labelVal8),
                      checkbox('LABEL 9', _labelVal9),
                      checkbox('LABEL 10', _labelVal10),
                    ]  // row widget
                  ), // row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      checkbox('LABEL 11', _labelVal11),
                      checkbox('LABEL 12', _labelVal12),
                      checkbox('LABEL 13', _labelVal13),
                      checkbox('LABEL 14', _labelVal14),
                      checkbox('LABEL 15', _labelVal15),
                    ]  // row widget
                  ), // row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      checkbox('LABEL 16', _labelVal16),
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
                      checkbox('LABEL 25', _labelVal25),
                    ]  // row widget
                  ), // row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      checkbox('LABEL 26', _labelVal26),
                      checkbox('LABEL 27', _labelVal27),
                      checkbox('LABEL 28', _labelVal28),
                      checkbox('LABEL 29', _labelVal29),
                      checkbox('LABEL 30', _labelVal30),
                    ]  // row widget
                  ), // row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      checkbox('LABEL 31', _labelVal31),
                      checkbox('LABEL 32', _labelVal32),
                      checkbox('LABEL 33', _labelVal33),
                      checkbox('LABEL 34', _labelVal34),
                      checkbox('LABEL 35', _labelVal35),
                    ]  // row widget
                  ), // row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      checkbox('LABEL 36', _labelVal36),
                      checkbox('LABEL 37', _labelVal37),
                      checkbox('LABEL 38', _labelVal38),
                      checkbox('LABEL 39', _labelVal39),
                      checkbox('LABEL 40', _labelVal40),
                    ]  // row widget
                  ), // row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      checkbox('LABEL 41', _labelVal41),
                      checkbox('LABEL 42', _labelVal42),
                      checkbox('LABEL 43', _labelVal43),
                      checkbox('LABEL 44', _labelVal44),
                      checkbox('LABEL 45', _labelVal45),
                    ]  // row widget
                  ), // row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      checkbox('LABEL 46', _labelVal46),
                      checkbox('LABEL 47', _labelVal47),
                      checkbox('LABEL 48', _labelVal48),
                      checkbox('LABEL 49', _labelVal49),
                      checkbox('LABEL 50', _labelVal50),
                    ]  // row widget
                  ), // row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      checkbox('LABEL 51', _labelVal51),
                      checkbox('LABEL 52', _labelVal52),
                      checkbox('LABEL 53', _labelVal53),
                      checkbox('LABEL 54', _labelVal54),
                      checkbox('LABEL 55', _labelVal55),
                    ]  // row widget
                  ), // row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      checkbox('LABEL 56', _labelVal56),
                      checkbox('LABEL 57', _labelVal57),
                      checkbox('LABEL 58', _labelVal58),
                      checkbox('LABEL 59', _labelVal59),
                      checkbox('LABEL 60', _labelVal60),
                    ]  // row widget
                  ), // row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      checkbox('LABEL 61', _labelVal61),
                      checkbox('LABEL 62', _labelVal62),
                      checkbox('LABEL 63', _labelVal63),
                      checkbox('LABEL 64', _labelVal64),
                      checkbox('LABEL 65', _labelVal65),
                    ]  // row widget 18 spaces
                  ), // row 18 spaces
                ],  // column widget
              ), //column
            ), // padding
          ),  //singlescroll
        ), // container
        style: TextStyle(color: Colors.white),
      ), // defaulttextstyle
    ); // scaffold
  } //body widget build

  Future<Uint8List> _generatePdf65() async {
    final doc = pw.Document();
    //add page
    doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.symmetric(vertical: 4.75 * PdfPageFormat.mm, horizontal: 10.7 * PdfPageFormat.mm),
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
                createLabel('5'),
              ], // widget
            ), // row1
            pw.Row(
              children: <pw.Widget> [
                createLabel('6'),
                createLabel('7'),
                createLabel('8'),
                createLabel('9'),
                createLabel('10'),
              ], //widget
            ),  //row2
            pw.Row(
              children: <pw.Widget> [
                createLabel('11'),
                createLabel('12'),
                createLabel('13'),
                createLabel('14'),
                createLabel('15'),
              ], //widget
            ),  //row3
            pw.Row(
              children: <pw.Widget> [
                createLabel('16'),
                createLabel('17'),
                createLabel('18'),
                createLabel('19'),
                createLabel('20'),
              ], //widget
            ),  //row4
            pw.Row(
              children: <pw.Widget> [
                createLabel('21'),
                createLabel('22'),
                createLabel('23'),
                createLabel('24'),
                createLabel('25'),
              ], //widget
            ),  //row5
            pw.Row(
              children: <pw.Widget> [
                createLabel('26'),
                createLabel('27'),
                createLabel('28'),
                createLabel('29'),
                createLabel('30'),
              ], //widget
            ),  //row6
            pw.Row(
              children: <pw.Widget> [
                createLabel('31'),
                createLabel('32'),
                createLabel('33'),
                createLabel('34'),
                createLabel('35'),
              ], //widget
            ),  //row7
            pw.Row(
              children: <pw.Widget> [
                createLabel('36'),
                createLabel('37'),
                createLabel('38'),
                createLabel('39'),
                createLabel('40'),
              ], //widget
            ),  //row8
            pw.Row(
              children: <pw.Widget> [
                createLabel('41'),
                createLabel('42'),
                createLabel('43'),
                createLabel('44'),
                createLabel('45'),
              ], //widget
            ),  //row9
            pw.Row(
              children: <pw.Widget> [
                createLabel('46'),
                createLabel('47'),
                createLabel('48'),
                createLabel('49'),
                createLabel('50'),
              ], //widget
            ),  //row10
            pw.Row(
              children: <pw.Widget> [
                createLabel('51'),
                createLabel('52'),
                createLabel('53'),
                createLabel('54'),
                createLabel('55'),
              ], //widget
            ),  //row11
            pw.Row(
              children: <pw.Widget> [
                createLabel('56'),
                createLabel('57'),
                createLabel('58'),
                createLabel('59'),
                createLabel('60'),
              ], //widget
            ),  //row12
            pw.Row(
              children: <pw.Widget> [
                createLabel('61'),
                createLabel('62'),
                createLabel('63'),
                createLabel('64'),
                createLabel('65'),
              ], //widget
            ),  //row13
          ], // widget
        ); // column
      })); // Page

    await Printing.sharePdf(bytes: await doc.save(), filename: 'Generated-Barcode.pdf');
  }

  createLabel(lbNumber) {
    if (lbList.contains('${lbNumber}')){
      return pw.Container(
        width: (40.0 * PdfPageFormat.mm),
        height: (21.2 * PdfPageFormat.mm),
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
        width: (40.0 * PdfPageFormat.mm), //label width 38.1mm
        height: (21.2 * PdfPageFormat.mm),
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
            Text(title),
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
                    case "LABEL 33":
                      _labelVal33 = value;
                      if (_labelVal33 == true) 
                        lbList.add('33');
                      if (_labelVal33 == false)
                        lbList.remove('33');
                      break;
                    case "LABEL 34":
                      _labelVal34 = value;
                      if (_labelVal34 == true) 
                        lbList.add('34');
                      if (_labelVal34 == false)
                        lbList.remove('34');
                      break;
                    case "LABEL 35":
                      _labelVal35 = value;
                      if (_labelVal35 == true) 
                        lbList.add('35');
                      if (_labelVal35 == false)
                        lbList.remove('35');
                      break;
                    case "LABEL 36":
                      _labelVal36 = value;
                      if (_labelVal36 == true) 
                        lbList.add('36');
                      if (_labelVal36 == false)
                        lbList.remove('36');
                      break;
                    case "LABEL 37":
                      _labelVal37 = value;
                      if (_labelVal37 == true) 
                        lbList.add('37');
                      if (_labelVal37 == false)
                        lbList.remove('37');
                      break;
                    case "LABEL 38":
                      _labelVal38 = value;
                      if (_labelVal38 == true) 
                        lbList.add('38');
                      if (_labelVal38 == false)
                        lbList.remove('38');
                      break;
                    case "LABEL 39":
                      _labelVal39 = value;
                      if (_labelVal39 == true) 
                        lbList.add('39');
                      if (_labelVal39 == false)
                        lbList.remove('39');
                      break;
                    case "LABEL 40":
                      _labelVal40 = value;
                      if (_labelVal40 == true) 
                        lbList.add('40');
                      if (_labelVal40 == false)
                        lbList.remove('40');
                      break;
                    case "LABEL 41":
                      _labelVal41 = value;
                      if (_labelVal41 == true) 
                        lbList.add('41');
                      if (_labelVal41 == false)
                        lbList.remove('41');
                      break;
                    case "LABEL 42":
                      _labelVal42 = value;
                      if (_labelVal42 == true) 
                        lbList.add('42');
                      if (_labelVal42 == false)
                        lbList.remove('42');
                      break;
                    case "LABEL 43":
                      _labelVal43 = value;
                      if (_labelVal43 == true) 
                        lbList.add('43');
                      if (_labelVal43 == false)
                        lbList.remove('43');
                      break;
                    case "LABEL 44":
                      _labelVal44 = value;
                      if (_labelVal44 == true) 
                        lbList.add('44');
                      if (_labelVal44 == false)
                        lbList.remove('44');
                      break;
                    case "LABEL 45":
                      _labelVal45 = value;
                      if (_labelVal45 == true) 
                        lbList.add('45');
                      if (_labelVal45 == false)
                        lbList.remove('45');
                      break;
                    case "LABEL 46":
                      _labelVal46 = value;
                      if (_labelVal46 == true) 
                        lbList.add('46');
                      if (_labelVal46 == false)
                        lbList.remove('46');
                      break;
                    case "LABEL 47":
                      _labelVal47 = value;
                      if (_labelVal47 == true) 
                        lbList.add('47');
                      if (_labelVal47 == false)
                        lbList.remove('47');
                      break;
                    case "LABEL 48":
                      _labelVal48 = value;
                      if (_labelVal48 == true) 
                        lbList.add('48');
                      if (_labelVal48 == false)
                        lbList.remove('48');
                      break;
                    case "LABEL 49":
                      _labelVal49 = value;
                      if (_labelVal49 == true) 
                        lbList.add('49');
                      if (_labelVal49 == false)
                        lbList.remove('49');
                      break;
                    case "LABEL 50":
                      _labelVal50 = value;
                      if (_labelVal50 == true) 
                        lbList.add('50');
                      if (_labelVal50 == false)
                        lbList.remove('50');
                      break;
                    case "LABEL 51":
                      _labelVal51 = value;
                      if (_labelVal51 == true) 
                        lbList.add('51');
                      if (_labelVal51 == false)
                        lbList.remove('51');
                      break;
                    case "LABEL 52":
                      _labelVal52 = value;
                      if (_labelVal52 == true) 
                        lbList.add('52');
                      if (_labelVal52 == false)
                        lbList.remove('52');
                      break;
                    case "LABEL 53":
                      _labelVal53 = value;
                      if (_labelVal53 == true) 
                        lbList.add('53');
                      if (_labelVal53 == false)
                        lbList.remove('53');
                      break;
                    case "LABEL 54":
                      _labelVal54 = value;
                      if (_labelVal54 == true) 
                        lbList.add('54');
                      if (_labelVal54 == false)
                        lbList.remove('54');
                      break;
                    case "LABEL 55":
                      _labelVal55 = value;
                      if (_labelVal55 == true) 
                        lbList.add('55');
                      if (_labelVal55 == false)
                        lbList.remove('55');
                      break;
                    case "LABEL 56":
                      _labelVal56 = value;
                      if (_labelVal56 == true) 
                        lbList.add('56');
                      if (_labelVal56 == false)
                        lbList.remove('56');
                      break;
                    case "LABEL 57":
                      _labelVal57 = value;
                      if (_labelVal57 == true) 
                        lbList.add('57');
                      if (_labelVal57 == false)
                        lbList.remove('57');
                      break;
                    case "LABEL 58":
                      _labelVal58 = value;
                      if (_labelVal58 == true) 
                        lbList.add('58');
                      if (_labelVal58 == false)
                        lbList.remove('58');
                      break;
                    case "LABEL 59":
                      _labelVal59 = value;
                      if (_labelVal59 == true) 
                        lbList.add('59');
                      if (_labelVal59 == false)
                        lbList.remove('59');
                      break;
                    case "LABEL 60":
                      _labelVal60 = value;
                      if (_labelVal60 == true) 
                        lbList.add('60');
                      if (_labelVal60 == false)
                        lbList.remove('60');
                      break;
                    case "LABEL 61":
                      _labelVal61 = value;
                      if (_labelVal61 == true) 
                        lbList.add('61');
                      if (_labelVal61 == false)
                        lbList.remove('61');
                      break;
                    case "LABEL 62":
                      _labelVal62 = value;
                      if (_labelVal62 == true) 
                        lbList.add('62');
                      if (_labelVal62 == false)
                        lbList.remove('62');
                      break;
                    case "LABEL 63":
                      _labelVal63 = value;
                      if (_labelVal63 == true) 
                        lbList.add('63');
                      if (_labelVal63 == false)
                        lbList.remove('63');
                      break;
                    case "LABEL 64":
                      _labelVal64 = value;
                      if (_labelVal64 == true) 
                        lbList.add('64');
                      if (_labelVal64 == false)
                        lbList.remove('64');
                      break;
                    case "LABEL 65":
                      _labelVal65 = value;
                      if (_labelVal65 == true) 
                        lbList.add('65');
                      if (_labelVal65 == false)
                        lbList.remove('65');
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
