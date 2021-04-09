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
//importing classes
import 'scanner.dart';
import 'generateBCode.dart';
import 'productsPage.dart';
import 'user_guide.dart';
import 'about.dart';

//import packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class homePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Uno Barcode Reader'),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
          image: AssetImage("assets/unoLayingDown.jpg"),
          fit: BoxFit.cover)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton.extended(
                  tooltip: 'Scann barcodes/qr codes',
                  label: Text('SCAN'),
                  heroTag: 'btn1',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>                             scanner()),
                    );  // Navigator.push 
                  }, // onPress
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ), // floating action button extended
                FloatingActionButton.extended(
                  tooltip: 'Generate a new barcode for personal use, save and print',
                  label: Text('GENERATE'),
                  heroTag: 'btn2',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>                             newGen()),
                    ); // Navigator
                  }, // onPress
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ), // floating action button extended
                FloatingActionButton.extended(
                  tooltip: 'Product list showing all saved items, minipulate options, edit, delete, print ect.',
                  label: Text('PRODUCT LIST'),
                  heroTag: 'btn3',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>                             productList()),
                    ); // Navigator.push
                  },  // onPress
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ), // floating action button extended
                FloatingActionButton.extended(
                  tooltip: 'User guide to explain how to use and licenses.',
                  label: Text('User Guide'),
                  heroTag: 'btn4',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>                             userGuide()),
                    );  // Navigator.push
                  }, // onPress
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ), // floating action button extended
                FloatingActionButton.extended(
                  tooltip: 'About the UnoAccessibility suite, other apps in the suite, contact details.',
                  label: Text('ABOUT OTHER APPS'),
                  heroTag: 'btn5',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>                             about()),
                    );  // Navigator.push
                  },  // onPress
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ), // floating action button extended
              ] // column widget
            ), // column (fab
          ), // padding
        ), // center
      ) // body container
    );  // scaffold
  }  // widget build
}