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
import 'productsPage.dart';
import 'editPage.dart';
import 'generateBCode.dart';
import 'home.dart';
import 'pickLabels32.dart';
import 'pickLabels35.dart';
import 'pickLabels36.dart';
//import 'pickLabels40.dart';
import 'pickLabels65.dart';


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

class createPdf extends StatefulWidget {
 
  createPdf({Key key, this.productName, this.indexCode, this.barcodeType, }) : super(key: key);

  String productName;
  String indexCode;
  String barcodeType;

  @override
  _createPdfState createState() => _createPdfState();
}

class _createPdfState extends State<createPdf> {

  String productName;
  String indexCode;
  String barcodeType;
  FlutterTts flutterTts = new FlutterTts();
  String numLabels;
  String startLabel;
  List<String> _pdfTemplet = ['40x30mm(4 Across, 8 Down, Total 32)', '37x37mm(5 Across, 7 Down, Total 35)', '48.9x29.6mm(4 Accross, 9 Down, Total 36)', '38.1x21.2mm(5 across, 13 down, TOTAL 65)']; 
  String _selectedPdfTemplet; // Option 2
  List labelsDic = [];
  var amountLabels;
  var startFrom;
  var checkLabels;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Create pdf templet to print'),
      ),
      body: DefaultTextStyle(
        child: Container(
          color: Colors.black,
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
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Choose a pdf templet from drop down menu and enter the fields to choose how many labels and where to start printing from.  Or you can choose the pdf templet and use the pick labels button to choose where on the page you wuld like to print yourself by selecting the checkboxes.'),
                ), // container
              ), // expanded
              Expanded(
                child: Container(
                  child: DropdownButton(
                    isExpanded: true, //Adding this property, does the magic
                    hint: Text('Please choose a label templet to print on'), // Not necessary for Option 1
                    value: _selectedPdfTemplet,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedPdfTemplet = newValue;
                      });
                    },
                    items: _pdfTemplet.map((pdfTemplet) {
                      return DropdownMenuItem(
                        child: new Text(pdfTemplet),
                        value: pdfTemplet,
                      );
                    }).toList(),
                  ),
                ), // container
              ), // expanded
              Expanded(
                child: Container(
                  child: TextFormField(                
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'How many labels would you like to print of this product?',
                    ), // decoration
                    enableInteractiveSelection: true,
                    onChanged: (value) {
                      setState(() {
                        numLabels = value;
                      }); // setstate
                    }, // onChange
                  ), // textFormField
                ), // container
              ), // expanded
              Expanded(
                child: Container(
                  child: TextFormField(                
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'From which label on the sheet would you like to start printing?',
                    ), // decoration
                    enableInteractiveSelection: true,
                    onChanged: (value) {
                      setState(() {
                        startLabel = value;
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
                      child: Container(
                        child: FloatingActionButton.extended(
                          tooltip: 'Cancel and return to products page',
                          label: Text('CANCEL'),
                          heroTag: 'cancel',
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => productList(),), (route) => route.isFirst); 
                          }, // onPress
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ), // floating action button extended
                      ), //container
                    ), // expanded
                    Expanded(
                      child: Container(
                        child: FloatingActionButton.extended(
                          tooltip: 'Create PDF Templet',
                          label: Text('CREATE PDF'),
                          heroTag: 'createPdf',
                          onPressed: () {
                            setState(() {
                              numberLabels(_selectedPdfTemplet, numLabels, startLabel);
                            }); // setstate
                          }, // onPress
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ), // floating action button extended
                      ), //container
                    ), // expanded
                    //choose labels and generate pdf
                        FloatingActionButton.extended(
                          tooltip: 'Pick labels to print',
                          label: Text('PICK LABELS'),
                          heroTag: 'pickLabels',
                          onPressed: () {
                            productName = widget.productName;
                            indexCode = widget.indexCode;
                            barcodeType = widget.barcodeType;
                            switch(_selectedPdfTemplet) {
                              case '40x30mm(4 Across, 8 Down, Total 32)': {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>                             pickLabels32(indexCode: indexCode, barcodeType: barcodeType, productName: productName)),
                                );
                              }
                              break;
                              case '37x37mm(5 Across, 7 Down, Total 35)': {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>                             pickLabels35(indexCode: indexCode, barcodeType: barcodeType, productName: productName)),
                                );
                              }
                              break;
                              case '48.9x29.6mm(4 Accross, 9 Down, Total 36)': {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>                             pickLabels36(indexCode: indexCode, barcodeType: barcodeType, productName: productName)),
                                );
                              }
                              break;
/*
                              case '45.7x25.4mm(4 Across, 10 Down, Total 40)': {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>                             pickLabels40(indexCode: indexCode, barcodeType: barcodeType, productName: productName)),
                                );
                              }
                              break;
*/
                              case '38.1x21.2mm(5 across, 13 down, TOTAL 65)': {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>                             pickLabels65(indexCode: indexCode, barcodeType: barcodeType, productName: productName)),
                                );
                              }
                              break;

                              default: {
                                flutterTts.speak('Please choose a pdf templet');
                              }
                              break;
                            }
                          }, // on press
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ), // floating action button extended

                  ] // row widget
                ), // row
              ), // container

            ] // column widget
          ), // column
        ), //  container
        style: TextStyle(color: Colors.white),
      ), // body DefaultTextStyle
    ); //scaffold
  }  // build widget


  numberLabels(var templetSheet, var numLabels, var startLabel) {
    switch(templetSheet) {
      case '40x30mm(4 Across, 8 Down, Total 32)': {
        //check if textfield is empty
        numLabels?.isEmpty ?? true ? flutterTts.speak('Enter a number between 1 and 32 to print on.') : startLabel?.isEmpty ?? true ? flutterTts.speak('Enter a number between 1 and 32 to start printing from.') : flutterTts.speak('Creating pdf templet.');
        //parse to int
        amountLabels = int. parse('${numLabels}');
        startFrom = int. parse('${startLabel}');
        int nmLabels = amountLabels + startFrom;
        if (nmLabels > 33) { 
          flutterTts.speak('Enter numbers that do not exceed the amount of labels');
        } else {
          addToList(amountLabels, startFrom);
          _generatePdf32();
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => homePage(),), (route) => route.isFirst);
        }
      }
        break;

      case '37x37mm(5 Across, 7 Down, Total 35)': {
        numLabels?.isEmpty ?? true ? flutterTts.speak('Enter a number between 1 and 35 to print on.') : startLabel?.isEmpty ?? true ? flutterTts.speak('Enter a number between 1 and 35 to start printing from.') : flutterTts.speak('Creating pdf templet.');

        amountLabels = int. parse('${numLabels}');
        startFrom = int. parse('${startLabel}');
        int nmLabels = amountLabels + startFrom;
        if (nmLabels > 36) { 
          flutterTts.speak('Enter numbers that do not exceed the amount of labels');
        } else {
          addToList(amountLabels, startFrom);
          _generatePdf35();
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => homePage(),), (route) => route.isFirst);
        }
        }
        break;

      case '48.9x29.6mm(4 Accross, 9 Down, Total 36)': {
        numLabels?.isEmpty ?? true ? flutterTts.speak('Enter a number between 1 and 36 to print on.') : startLabel?.isEmpty ?? true ? flutterTts.speak('Enter a number between 1 and 36 to start printing from.') : flutterTts.speak('Creating pdf templet.');

        amountLabels = int. parse('${numLabels}');
        startFrom = int. parse('${startLabel}');
        int nmLabels = amountLabels + startFrom;
        if (nmLabels > 37) { 
          flutterTts.speak('Enter numbers that do not exceed the amount of labels');
        } else {
          addToList(amountLabels, startFrom);
          _generatePdf36();
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => homePage(),), (route) => route.isFirst);

        }
        }
        break;


/*
      case '45.7x25.4mm(4 Across, 10 Down, Total 40)': {
        numLabels?.isEmpty ?? true ? flutterTts.speak('Enter a number between 1 and 40 to print on.') : startLabel?.isEmpty ?? true ? flutterTts.speak('Enter a number between 1 and 40 to start printing from.') : flutterTts.speak('Creating pdf templet.');

        amountLabels = int. parse('${numLabels}');
        startFrom = int. parse('${startLabel}');
        int nmLabels = amountLabels + startFrom;
        if (nmLabels > 41) { 
          flutterTts.speak('Enter numbers that do not exceed the amount of labels');
        } else {
          addToList(amountLabels, startFrom);
          _generatePdf40();
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => homePage(),), (route) => route.isFirst);
        }
    }
        break;
*/
      case '38.1x21.2mm(5 across, 13 down, TOTAL 65)': {
        numLabels?.isEmpty ?? true ? flutterTts.speak('Enter a number between 1 and 65 to print on.') : startLabel?.isEmpty ?? true ? flutterTts.speak('Enter a number between 1 and 65 to start printing from.') : flutterTts.speak('Creating pdf templet.');
        amountLabels = int. parse('${numLabels}');
        startFrom = int. parse('${startLabel}');
        int nmLabels = amountLabels + startFrom;
        if (nmLabels > 66) { 
          flutterTts.speak('Enter numbers that do not exceed the amount of labels');
        } else {
          addToList(amountLabels, startFrom);
          _generatePdf65();
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => homePage(),), (route) => route.isFirst);
        }

      }
        break;


        default: { 
            flutterTts.speak('Please select a templet'); amountLabels > 65 ? flutterTts.speak('Only 65 labels on the page') : flutterTts.speak('ok');
          } 
          break; 

    }
  }

  addToList(var numberOfLabels, startFromLabel) {
    labelsDic.clear (); 
    int nLabels = numberOfLabels + startFromLabel;
    for (var i = startFromLabel; i < nLabels; i++) {
      labelsDic.add(i);
    }
    //print(labelsDic);
  }
 
  void unFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

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
                createLabel32(1),
                createLabel32(2),
                createLabel32(3),
                createLabel32(4),
              ], // widget
            ), // row1
            pw.Row(
              children: <pw.Widget> [
                createLabel32(5),
                createLabel32(6),
                createLabel32(7),
                createLabel32(8),
              ], //widget
            ),  //row2
            pw.Row(
              children: <pw.Widget> [
                createLabel32(9),
                createLabel32(10),
                createLabel32(11),
                createLabel32(12),
              ], //widget
            ),  //row3
            pw.Row(
              children: <pw.Widget> [
                createLabel32(13),
                createLabel32(14),
                createLabel32(15),
                createLabel32(16),
              ], //widget
            ),  //row4
            pw.Row(
              children: <pw.Widget> [
                createLabel32(17),
                createLabel32(18),
                createLabel32(19),
                createLabel32(20),
              ], //widget
            ),  //row5
            pw.Row(
              children: <pw.Widget> [
                createLabel32(21),
                createLabel32(22),
                createLabel32(23),
                createLabel32(24),
              ], //widget
            ),  //row6
            pw.Row(
              children: <pw.Widget> [
                createLabel32(25),
                createLabel32(26),
                createLabel32(27),
                createLabel32(28),
              ], //widget
            ),  //row7
            pw.Row(
              children: <pw.Widget> [
                createLabel32(29),
                createLabel32(30),
                createLabel32(31),
                createLabel32(32),
              ], //widget
            ),  //row8
          ], // widget
        ); // column
      })); // Page

    await Printing.sharePdf(bytes: await doc.save(), filename: 'Generated-Barcode.pdf');
  }

  createLabel32(var lbNumber) {
    if (labelsDic.contains(lbNumber)){
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

  //35
  Future<Uint8List> _generatePdf35() async {
    final doc = pw.Document();
    //add page
    doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.symmetric(vertical: 5.0 * PdfPageFormat.mm, horizontal: 13.3 * PdfPageFormat.mm),
      //build
      build: (pw.Context context) {
        return pw.Column(

          children: <pw.Widget>[
            pw.Row(
              children: <pw.Widget> [
                createLabel35(1),
                createLabel35(2),
                createLabel35(3),
                createLabel35(4),
                createLabel35(5),
              ], // widget
            ), // row1
            pw.Row(
              children: <pw.Widget> [
                createLabel35(6),
                createLabel35(7),
                createLabel35(8),
                createLabel35(9),
                createLabel35(10),
              ], //widget
            ),  //row2
            pw.Row(
              children: <pw.Widget> [
                createLabel35(11),
                createLabel35(12),
                createLabel35(13),
                createLabel35(14),
                createLabel35(15),
              ], //widget
            ),  //row3
            pw.Row(
              children: <pw.Widget> [
                createLabel35(16),
                createLabel35(17),
                createLabel35(18),
                createLabel35(19),
                createLabel35(20),
              ], //widget
            ),  //row4
            pw.Row(
              children: <pw.Widget> [
                createLabel35(21),
                createLabel35(22),
                createLabel35(23),
                createLabel35(24),
                createLabel35(25),
              ], //widget
            ),  //row5
            pw.Row(
              children: <pw.Widget> [
                createLabel35(26),
                createLabel35(27),
                createLabel35(28),
                createLabel35(29),
                createLabel35(30),
              ], //widget
            ),  //row6
            pw.Row(
              children: <pw.Widget> [
                createLabel35(31),
                createLabel35(32),
                createLabel35(33),
                createLabel35(34),
                createLabel35(35),
              ], //widget
            ),  //row7
          ], // widget
        ); // column
      })); // Page

    await Printing.sharePdf(bytes: await doc.save(), filename: 'Generated-Barcode.pdf');
  }

  createLabel35(lbNumber) {
    if (labelsDic.contains(lbNumber)){
      return pw.Container(
        width: (39.0 * PdfPageFormat.mm),
        height: (38.9 * PdfPageFormat.mm),
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
        width: (38.9 * PdfPageFormat.mm), //label width 38.1mm
        height: (39.0 * PdfPageFormat.mm),
      ); //container      
  }

  //36
  Future<Uint8List> _generatePdf36() async {
    final doc = pw.Document();
    //add page
    doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.symmetric(vertical: 4.8 * PdfPageFormat.mm, horizontal: 15.3 * PdfPageFormat.mm),
      //build
      build: (pw.Context context) {
        return pw.Column(

          children: <pw.Widget>[
            pw.Row(
              children: <pw.Widget> [
                createLabel36(1),
                createLabel36(2),
                createLabel36(3),
                createLabel36(4),

              ], // widget
            ), // row1
            pw.Row(
              children: <pw.Widget> [
                createLabel36(5),
                createLabel36(6),
                createLabel36(7),
                createLabel36(8),
              ], //widget
            ),  //row2
            pw.Row(
              children: <pw.Widget> [
                createLabel36(9),
                createLabel36(10),
                createLabel36(11),
                createLabel36(12),
              ], //widget
            ),  //row3
            pw.Row(
              children: <pw.Widget> [
                createLabel36(13),
                createLabel36(14),
                createLabel36(15),
                createLabel36(16),
              ], //widget
            ),  //row4
            pw.Row(
              children: <pw.Widget> [
                createLabel36(17),
                createLabel36(18),
                createLabel36(19),
                createLabel36(20),
              ], //widget
            ),  //row5
            pw.Row(
              children: <pw.Widget> [
                createLabel36(21),
                createLabel36(22),
                createLabel36(23),
                createLabel36(24),
                createLabel36(25),
                createLabel36(26),
                createLabel36(27),
                createLabel36(28),
              ], //widget
            ),  //row6
            pw.Row(
              children: <pw.Widget> [
                createLabel36(29),
                createLabel36(30),
                createLabel36(31),
                createLabel36(32),
              ], //widget
            ),  //row7
            pw.Row(
              children: <pw.Widget> [
                createLabel36(33),
                createLabel36(34),
                createLabel36(35),
                createLabel36(36),
              ], //widget
            ),  //row8
          ], // widget
        ); // column
      })); // Page

    await Printing.sharePdf(bytes: await doc.save(), filename: 'Generated-Barcode.pdf');
  }

  createLabel36(lbNumber) {
    if (labelsDic.contains(lbNumber)){
      return pw.Container(
        width: (45.7 * PdfPageFormat.mm),
        height: (25.4 * PdfPageFormat.mm),
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
        width: (45.7 * PdfPageFormat.mm), //label width 38.1mm
        height: (25.4 * PdfPageFormat.mm),
      ); //container      
  }
/*
  //40
  Future<Uint8List> _generatePdf40() async {
    final doc = pw.Document();
    //add page
    doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.symmetric(vertical: 9.7 * PdfPageFormat.mm, horizontal: 21.5 * PdfPageFormat.mm),
      //build
      build: (pw.Context context) {
        return pw.Column(

          children: <pw.Widget>[
            pw.Row(
              children: <pw.Widget> [
                createLabel40(1),
                createLabel40(2),
                createLabel40(3),
                createLabel40(4),
              ], // widget
            ), // row1

            pw.Row(
              children: <pw.Widget> [
                createLabel40(5),
                createLabel40(6),
                createLabel40(7),
                createLabel40(8),
              ], //widget
            ),  //row2
            pw.Row(
              children: <pw.Widget> [
                createLabel40(9),
                createLabel40(10),
                createLabel40(11),
                createLabel40(12),
              ], //widget
            ),  //row3
            pw.Row(
              children: <pw.Widget> [
                createLabel40(13),
                createLabel40(14),
                createLabel40(15),
                createLabel40(16),
              ], //widget
            ),  //row4
            pw.Row(
              children: <pw.Widget> [
                createLabel40(17),
                createLabel40(18),
                createLabel40(19),
                createLabel40(20),
              ], //widget
            ),  //row5
            pw.Row(
              children: <pw.Widget> [
                createLabel40(21),
                createLabel40(22),
                createLabel40(23),
                createLabel40(24),
              ], //widget
            ),  //row6
            pw.Row(
              children: <pw.Widget> [
                createLabel40(25),
                createLabel40(26),
                createLabel40(27),
                createLabel40(28),
              ], //widget
            ),  //row7
            pw.Row(
              children: <pw.Widget> [
                createLabel40(29),
                createLabel40(30),
                createLabel40(31),
                createLabel40(32),
              ], //widget
            ),  //row8
            pw.Row(
              children: <pw.Widget> [
                createLabel40(33),
                createLabel40(34),
                createLabel40(35),
                createLabel40(36),
              ], //widget
            ),  //row9
            pw.Row(
              children: <pw.Widget> [
                createLabel40(37),
                createLabel40(38),
                createLabel40(39),
                createLabel40(40),
              ], //widget
            ),  //row10
          ], // widget
        ); // column
      })); // Page

    await Printing.sharePdf(bytes: await doc.save(), filename: 'Generated-Barcode.pdf');
  }

  createLabel40(lbNumber) {
    if (labelsDic.contains(lbNumber)){
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
*/

  //65
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
                createLabel65(1),
                createLabel65(2),
                createLabel65(3),
                createLabel65(4),
                createLabel65(5),
              ], // widget
            ), // row1
            pw.Row(
              children: <pw.Widget> [
                createLabel65(6),
                createLabel65(7),
                createLabel65(8),
                createLabel65(9),
                createLabel65(10),
              ], //widget
            ),  //row2
            pw.Row(
              children: <pw.Widget> [
                createLabel65(11),
                createLabel65(12),
                createLabel65(13),
                createLabel65(14),
                createLabel65(15),
              ], //widget
            ),  //row3
            pw.Row(
              children: <pw.Widget> [
                createLabel65(16),
                createLabel65(17),
                createLabel65(18),
                createLabel65(19),
                createLabel65(20),
              ], //widget
            ),  //row4
            pw.Row(
              children: <pw.Widget> [
                createLabel65(21),
                createLabel65(22),
                createLabel65(23),
                createLabel65(24),
                createLabel65(25),
              ], //widget
            ),  //row5
            pw.Row(
              children: <pw.Widget> [
                createLabel65(26),
                createLabel65(27),
                createLabel65(28),
                createLabel65(29),
                createLabel65(30),
              ], //widget
            ),  //row6
            pw.Row(
              children: <pw.Widget> [
                createLabel65(31),
                createLabel65(32),
                createLabel65(33),
                createLabel65(34),
                createLabel65(35),
              ], //widget
            ),  //row7
            pw.Row(
              children: <pw.Widget> [
                createLabel65(36),
                createLabel65(37),
                createLabel65(38),
                createLabel65(39),
                createLabel65(40),
              ], //widget
            ),  //row8
            pw.Row(
              children: <pw.Widget> [
                createLabel65(41),
                createLabel65(42),
                createLabel65(43),
                createLabel65(44),
                createLabel65(45),
              ], //widget
            ),  //row9
            pw.Row(
              children: <pw.Widget> [
                createLabel65(46),
                createLabel65(47),
                createLabel65(48),
                createLabel65(49),
                createLabel65(50),
              ], //widget
            ),  //row10
            pw.Row(
              children: <pw.Widget> [
                createLabel65(51),
                createLabel65(52),
                createLabel65(53),
                createLabel65(54),
                createLabel65(55),
              ], //widget
            ),  //row11
            pw.Row(
              children: <pw.Widget> [
                createLabel65(56),
                createLabel65(57),
                createLabel65(58),
                createLabel65(59),
                createLabel65(60),
              ], //widget
            ),  //row12
            pw.Row(
              children: <pw.Widget> [
                createLabel65(61),
                createLabel65(62),
                createLabel65(63),
                createLabel65(64),
                createLabel65(65),
              ], //widget
            ),  //row13
          ], // widget
        ); // column
      })); // Page

    await Printing.sharePdf(bytes: await doc.save(), filename: 'Generated-Barcode.pdf');
  }


  createLabel65(var lbNumber) {

    if (labelsDic.contains(lbNumber)){
      //print(labelsDic);

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


} // class