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
import 'mitLicense.dart';

// import packages
import 'package:flutter/material.dart';

class userGuide extends StatefulWidget {

  @override
  _userGuideState createState() => _userGuideState();

}

class _userGuideState extends State<userGuide> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("How to use"),
        actions: [
          IconButton(
            icon: Text('Software License'),
            tooltip: 'Software license for Uno Barcode Reader',
            onPressed: () { 
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>                             appLicense()),
              );  // Navigator.push 
            },
          ),
          IconButton(
            icon: Text('Applicable License'),
            tooltip: 'Applicable licenses for Uno Barcode Reader',
            onPressed: () { 
              showLicensePage(context: context);
            },
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Step by step how to use:'),
              Text(''),
              Text("""This is a app to detect barcodes/qr codes especially in mind for use of blind and parcially sigted persons."""),
              Text(''),
            ], // column widget
          ), // column
        ), // single scroll child
      ), // body container
    ); // scaffold
  } // widget build

  void showLicensePage({
    @required BuildContext context,
    String applicationName,
    String applicationVersion,
    Widget applicationIcon,
    String applicationLegalese,
    bool useRootNavigator = false,
  }) {
    assert(context != null);
    assert(useRootNavigator != null);
    Navigator.of(context, rootNavigator: useRootNavigator)
        .push(MaterialPageRoute<void>(
      builder: (BuildContext context) => LicensePage(
        applicationName: applicationName,
        applicationVersion: applicationVersion,
        applicationIcon: applicationIcon,
        applicationLegalese: applicationLegalese,
      ),
    ));
  }
}

