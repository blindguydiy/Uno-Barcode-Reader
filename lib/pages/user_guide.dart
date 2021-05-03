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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Step by step how to use:'),
              Text(''),
              Text("""Below you will find information about the app, how to use the app, contact details to contact me and licenses applicable to the app."""),
              Text(''),
  Text(""" ABOUT THE APP"""),
              Text(''),
              Text("""This app was designed and developed with blind users in mind."""),
              Text(''),
              Text("""Most  products/items you buy in a shop will have a barcode/qr code for the shops to identify the product and other information not available to the public like pricing, manufacturer, country of manufacturing ect.  But we only need to identify the product/item and do not need all the other information."""),
              Text(''),
              Text("""With this app you scan barcodes/qr codes to identify products/items.  It also allows you to generate and print new barcodes for personal use, barcode/qr code that you saved to the device can also be printed and used to label  containers or packages used  for products/items with existing barcodes."""),
             Text(''),
Text("""When the app starts the home page contains 5 buttons.  'Scan', 'Generate', 'Product List', User Guide' and 'About'. It also have a image of Uno my retired guide dog in the background.  This is where the app got its name from."""), 
              Text(''),
              Text("""HOW TO USE"""),
              Text(''),
              Text("""Explanation of buttons and screens"""),
              Text(''),
              Text("""SCAN BUTTON:"""),
              Text(''),
              Text("""This will open a camera view screen that allow you to scan products/items to find the barcode.  The flash is automatically set to on."""),
              Text(''),
              Text("""On this screen there are three additional buttons, flash off, pause and Resume
which the user can also make use of."""),
              Text(''),
              Text("""The 'Flash off' button can be used to toggle the flash on or of, The 'pause' button can be used to pause the camera stream that is detecting the barcode/qr code identified and move to scan and identify other products.  The 'resume' button resume's' the streaming of the camera to detect the barcodes/qr codes."""),
              Text(''),
              Text("""On first use no products/items is saved to the device,  so when a barcode/qr code is detected an 'add item' screen will open to allow you to type in the name of the product if you know the product/item name or Else you also have the option to 'search the web' to identify the product.  Please note with this option all products is not always correct or available on the internet."""),
              Text(''),
              Text("""You can at any time use the 'cancel' button to quit the 'add item' screen and return to the camera preview screen to keep on scanning,  if you wish to save the product/item to your device you can use the 'save' button after entering the product/item name to save it to your device."""),
              Text(''),
              Text("""Please note scanning the product/item could ask you up to 3 times to enter a product/item name.  This is due to that a lot of products have more than one type of barcode/qr code on the packaging. After entering the product/item name for each of these barcode/qr code it will identify the product correctly."""),
              Text(''),
              Text("""If the product/item was previously saved to your device it will give spoken feedback what product/item you have scanned."""),
              Text(''),
              Text("""Generate button:
"""),
              Text(''),
              Text("""With this option you can create a unique 4 digit  barcode of your choice for personal use. For Example, When you buy Meat  in bulk and repackaged to smaller packages, you can label the smaller packages with your unique code for identification purpose, marking containers in fridge or freezer with left overs or anything else you can think of that you wish to be identified that do not have a barcode."""),
              Text(''),
              Text("""Then there is a 'cancel' button that will take you back to the home page There is also a 'Save' button if you wish to create the product/item and print the barcode label later."""),
              Text(''),
              Text("""The last button, 'pick labels' button, this button will save automatically the product/item to the device and then take you to the next screen where you can choose the labels you wish to print on."""),
              Text(''),
              Text("""The current available labels layout is an A4 sheet with label sizes of 38.1 x 21.2 mm.  It is 5 labels across and 13 labels down.  The total number of labels is 65 on a sheet."""),
              Text(''),
              Text("""Here you can choose which labels you wish to print by checking the checkboxes.  You can print one label or choose how many you want to print and also where on the sheet you want to print should you have already  a used sheet and only some labels is available."""),
              Text(''),
              Text("""On this screen after choosing how many labels and where on the  sheet you wish to print, at the top on the right you will find a 'share' button to create the  pdf template to send to your email or to print."""),
              Text(''),
              Text("""Product List button:"""),
              Text(''),
              Text("""On this screen you will get a list of products/items saved to your device. You can choose any of the items by double clicking on it.  It then will open a 'edit page'."""),
              Text(''),
              Text("""This screen has a text field showing the barcode/qr code type and the barcode.  Then it has a text field with the product/item name where you can edit or change the name should you need to."""),
              Text(''),
              Text("""Then it has 6 buttons. 'cancel' will take you back to the productlist screen. 'Save' lets you save the product if you have made any changes to the name. 'search web' if you wish to search the web for product. 'delete' to delete the product/item from the list. 'delete all' deletes all saved products/items saved to the device. 'pick labels' let you print the chosen product/item barcode on an A4 sheet with labels 38.1 x 21.2 mm. Like with the generate barcode you can choose how many and where on the sheet you wish to print and then use the share button top right to export the pdf templet to print."""),
              Text(''),
              Text("""User Guide button:"""),
              Text(''),
              Text("""This is where you are currently to give you a idea how to use the app and also will have the licenses and contact details for feedback and suggestions."""),
              Text(''),
              Text("""About button:"""),
              Text(''),
              Text("""This will give you information on what the Uno Accesibility suite is about and what other apps are in the process to be developed."""),
              Text(''),
              Text("""Contact:"""),
              Text(''),
              Text("""Developer: Hendrik Lubbe"""),
              Text("""Email:  blindguydiy@gmail.com<mailto:blindguydiy@gmail.com>"""),
              Text("""Whatsapp or call: + 27795235842"""),
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

