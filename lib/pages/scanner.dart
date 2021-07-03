//import classes
import 'addItem.dart';

//import packages
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
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:html/parser.dart' show parse;
//import 'package:http/http.dart' as http;
//import 'package:html/dom.dart' as dom;


const flashOn = 'FLASH ON';
const flashOff = 'FLASH OFF';

class scanner extends StatefulWidget {

  const scanner({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _scannerState();
}

class _scannerState extends State<scanner> {

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;
  var flashState = flashOff;
  var ite;
  var barcodeType;
  FlutterTts _flutterTts;
  bool isPlaying = false;
 
  void initState() {
    super.initState();
    initializeTts();
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ), // QRView
          ), // expanded
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                ? Text(
                  'Barcode Type: ${describeEnum(result.format)}   Data: ${result.code}')
                : Text('Scan a code'),
            ), //center
          ), // expanded
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(8),
                  child: RaisedButton(
                    onPressed: () {
                      if (controller != null) {
                        controller.toggleFlash();
                        if (_isFlashOn(flashState)) {
                          setState(() {
                            flashState = flashOff;
                          });
                        } else {
                          setState(() {
                            flashState = flashOn;
                          });
                        }
                      }
                    },
                    child: Text(flashState, style: TextStyle(fontSize: 20)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  child: RaisedButton(
                    onPressed: () {
                      controller?.pauseCamera();
                    },
                    child: Text('pause', style: TextStyle(fontSize: 20)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  child: RaisedButton(
                    onPressed: () {
                      controller?.resumeCamera();
                    },
                    child: Text('resume', style: TextStyle(fontSize: 20)),
                  ),
                )
              ], // row widget
            ), // row
          ), // container
        ], // column widget
      ),   //body column
    );  // scaffold
  }  // widget build

  bool _isFlashOn(String current) {
    return flashOn == current;
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      findBarCode();
    });
    controller.toggleFlash();
  }

  findBarCode() async {
    //see if barcode is detected
    if (result != null) 
      barcodeType = '${describeEnum(result.format)}';
      ite = '${result.code}';
      var box = Hive.box<Product>('products');
      var _product = box.get(ite);
      //see if detected barcode is in box
      if (_product != null)
await _speak(_product.itemName);
      else 
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>                             adItem(ite: ite, barcodeType: barcodeType)),
        );
  }    

  @override
  void dispose() {
    controller?.dispose();
    _flutterTts.stop();

    super.dispose();
  }

  void searchWeb() async {
    //const url = https://www.google.com/search?q=query+goes+here
    var url = 'https://barcodesdatabase.org/barcode/5449000009067'; //'https://www.bing.com/search?q="barcode: ${widget.indexCode}"';
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }


  initializeTts() {
    _flutterTts = FlutterTts();

    _flutterTts.setStartHandler(() {
      setState(() {
        isPlaying = true;
      });
    });

    _flutterTts.setCompletionHandler(() {
      setState(() {
        isPlaying = false;
      });
    });

    _flutterTts.setErrorHandler((err) {
      setState(() {
        print("error occurred: " + err);
        isPlaying = false;
      });
    });
  }

  Future _speak(String text) async {
    await _flutterTts.awaitSpeakCompletion(true);

    if (text != null && text.isNotEmpty) {
      var result = await _flutterTts.speak(text);
      if (result == 1)
        setState(() {
          isPlaying = true;
        });
    }
  }

  Future _stop() async {
    var result = await _flutterTts.stop();
    if (result == 1)
      setState(() {
        isPlaying = false;
      });
  }

  void setTtsLanguage() async {
    await _flutterTts.setLanguage("en-US");
  }

} // class