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
import 'dart:io'; 
import 'dart:convert';
import 'package:share_plus/share_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_tts/flutter_tts.dart';


class productList extends StatefulWidget {
  productList({Key key,}) : super(key: key);

  @override
  _productListState createState() => _productListState();
}

class _productListState extends State<productList> {

  FlutterTts _flutterTts;
  bool isPlaying = false;
  String codeDialog;
  String valueText;
  var indexCode;
  String productName;
  var Index;
  var barcodeType;

  @override
  void initState() {
    super.initState();
    initializeTts();
  }

  void dispose() async {
    super.dispose();
    _flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products List'),
        actions: [
          IconButton(
            icon: Text('EXPORT'), 
            tooltip: 'Export database',
            onPressed: () { 
              exportData();
            }, // on press
          ), // icon button
          IconButton(
            icon: Text('IMPORT'), 
            tooltip: 'Import database',
            onPressed: () { 
              _importBackup();
            }, // on press
          ), // icon button
          IconButton(
            icon: Text('SHARE'), 
            tooltip: 'Share backup file',
            onPressed: () { 
              shareBackup();
              //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => homePage(),), (route) => route.isFirst); 
            }, // on press
          ), // icon button
        ], // action
      ), // appbar
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
              List sortedList = [];
              var items = box.values.toList();
              items.sort((a, b) => a.itemName.compareTo(b.itemName));
              for (var q in items)
                sortedList.add({'itemName' : q.itemName, 'barCode' : q.barCode, 'bcType' : q.bcType});

              return ListTile(
                title: Text(sortedList[index]['itemName']), 
                onTap: () { 
                  Index = index;
                  indexCode = sortedList[index]['barCode']; 
                  productName = sortedList[index]['itemName']; 
                  barcodeType = sortedList[index]['bcType']; 
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


  Future<File> _importBackup() async {
    //permissions for more than one action
    var status = await Permission.storage.status;
    if (status.isUndetermined) {
      // You can request multiple permissions at once.
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
        //Permission.camera,
      ].request();
      //print(statuses[Permission.storage]); // it should print PermissionStatus.granted
    }

    var directory = await Directory('/storage/emulated/0/unoBarcodeReader');
    if (File('${directory.path}/backup_barcode.json').existsSync()) {
    //open external storageOpen the file with 
    File jsonFile = await File("${directory.path}/backup_barcode.json");
    List<dynamic> dataTest = json.decode(jsonFile.readAsStringSync());

    for (var i in dataTest) {
      productName  = i['item_name'];
      indexCode = i['barcode'];
      barcodeType = i['bctype'];
      saveHive(indexCode, productName, indexCode, barcodeType);
    }
    } else {
      _speak('No backup file available.  You first have to create or get a copy of a backup file');
    }
  }

  Future<File> exportData() async {
    List<Map<String, dynamic>> exportData = [];

    int count = 0;
    var box = Hive.box<Product>('products');
    var _products = box.values;
    var items = box.values.toList();
    items.sort((a, b) => a.itemName.compareTo(b.itemName));
    items.forEach((element) => print(element.itemName));
    
    int index = _products.length;

    for (int i = 0; i < index; i++) {
      var _product = box.getAt(count);
exportData.add({'item_name' : _product.itemName, 'barcode' : _product.barCode, 'bctype' : _product.bcType});
      count++;
    }
    print(exportData);
    var status = await Permission.storage.status;
    if (status.isUndetermined) {
      // You can request multiple permissions at once.
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
        //Permission.camera,
      ].request();
      //print(statuses[Permission.storage]); // it should print PermissionStatus.granted
  
    }
    var directory = await Directory('/storage/emulated/0/unoBarcodeReader').create(recursive: true);

    File backupFile = File('/storage/emulated/0/unoBarcodeReader/backup_barcode.json');

    try {
      /// barcodeBox is the [Box] object from the Hive package, usually exposed inside a [ValueListenableBuilder] or via [Hive.box()]
      backupFile = await backupFile.writeAsString(jsonEncode(exportData));
      _speak('Exporting backup file to: ${directory.path}/backup_barcode.json ');

      return backupFile;
    } catch (e) {
      // TODO: handle exception
      print(e);
    }
  }

  Future shareBackup() async {
    //permissions for more than one action
    var status = await Permission.storage.status;
    if (status.isUndetermined) {
      // You can request multiple permissions at once.
        Map<Permission, PermissionStatus> statuses = await [
          Permission.storage,
          //Permission.camera,
        ].request();
      //print(statuses[Permission.storage]); // it should print PermissionStatus.granted
    }

    var directory = await Directory('/storage/emulated/0/unoBarcodeReader');

    if (File('${directory.path}/backup_barcode.json').existsSync()) { 
      await Share.shareFiles(['${directory.path}/backup_barcode.json']);
    } else {
      _speak('You first have to create a backup file before you can share it.  To do this use the export button to create a backup file.');
    }
  }

  void saveHive(String bar_code, String item_name, String bCode, String bcType) async {
    var box = Hive.box<Product>('products');
    box.put(bar_code, Product(item_name, bCode, bcType));
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

}