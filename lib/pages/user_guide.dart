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
import 'privacyPolicy.dart';

// import packages
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'dart:io';

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
          IconButton(
            icon: Text('Privacy Policy'),
            tooltip: 'Privacy Policy',
            onPressed: () { 
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>                             privacyPolicy()),
              );  // Navigator.push 
            },
          ),

        ],
      ),
      body: DefaultTextStyle(
        child: Container(
          color: Colors.black,
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Semantics(
                  header: true,
                  child: Text('STEP BY STEP HOW TO USE:', style: TextStyle(
                    //color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40)) //HeadingWidget()
                ), // Semantics
                Text("""Below you will find information about the app, how to use the app, contact details to contact me and licenses applicable to the app."""),
                Semantics(
                  header: true,
                  child: Text(""" ABOUT THE APP""", style: TextStyle(
                    //color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40)) //HeadingWidget()
                ), // Semantics
                Text("""This app was designed and developed with blind users in mind.\n"""),
                Text("""Most  products/items you buy in a shop will have a barcode/qr code for the shops to identify the product and other information not available to the public like pricing, manufacturer, country of manufacturing ect.  But we only need to identify the product/item and do not need all the other information.\n"""),
                Text("""With this app you scan barcodes/qr codes to identify products/items.  It also allows you to generate and print new barcodes for personal use, barcode/qr code that you saved to the device can also be printed and used to label  containers or packages used  for products/items with existing barcodes.\n"""),
                Text("""When the app starts the home page contains 5 buttons.  'SCAN', 'GENERATE', 'PRODUCT LIST', USER GUIDE' and 'ABOUT'. It also have a image of Uno my retired guide dog in the background.  This is where the app got its name from.\n"""), 
                Semantics(
                  header: true,
                  child: Text("""HOW TO USE\n""", style: TextStyle(
                    //color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40)) //HeadingWidget())
                ), // Semantics
                Semantics(
                  header: true,
                  child: Text("""Explanation of buttons and screens\n""", style: TextStyle(
                    //color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40)) //HeadingWidget())
                ), // Semantics
                Semantics(
                  header: true,
                  child: Text("""SCAN BUTTON:""", style: TextStyle(
                    //color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40)) //HeadingWidget())
                ),  // Semantics
                Text("""This opens a camera view screen that will allow you to scan products/items to find the barcode.  The flash is automatically set to on."""),
                Text("""On this screen there are three additional buttons, flash off, pause and Resume which the user can also make use of.\n"""),
                Text("""The 'Flash off' button can be used to toggle the flash on or of, The 'pause' button can be used to pause the camera stream that is detecting the barcode/qr code identified and move to scan and identify other products.  The 'resume' button resume's' the streaming of the camera to detect the barcodes/qr codes.\n"""),
                Text("""On first use no products/items is saved to the device,  so when a barcode/qr code is detected a 'add item' screen will open. This will have a empty texfield to allow you to type in the name of the product if you know the product/item name or Else you also have the option to 'search the web' to identify the product.  Please note with this option all products is not always correct or available on the internet.  In future versions you will have the option to search the international barcode lookup directly while scanning.  But this will require you to be connected to the internet.\n"""),
                Text("""You can at any time use the 'cancel' button to quit the 'add item' screen and return to the camera preview screen to keep on scanning,  if you wish to save the product/item to your device you can use the 'save' button after entering the product/item name to save it to your device.\n"""),
                Text("""Please note scanning the product/item could ask you up to 3 times to enter a product/item name.  This is due to that a lot of products have more than one type of barcode/qr code on the packaging. After entering the product/item name for each of these barcode/qr code it will identify the product correctly.\n"""),
                Text("""If the product/item was previously saved to your device it will give spoken feedback what product/item you have scanned.\n"""),
                Semantics(
                  header: true,
                  child: Text("""GENERATE BUTTON:""", style: TextStyle(
        //color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 40)) //HeadingWidget())
                ),
                Text("""With this option you can create a unique 4 digit  barcode of your choice for personal use. For Example, When you buy Meat  in bulk and repackaged to smaller packages, you can label the smaller packages with your unique code for identification purpose, marking containers in fridge or freezer with left overs or anything else you can think of that you wish to be identified that do not have a barcode.\n"""),
                Text("""Then there is a 'cancel' button that will take you back to the home page There is also a 'Save' button if you wish to create the product/item and print the barcode label later.\n\n"""),
                Text("""The last button is 'Create PDF', this will save the barcode and item to device and take you to the next screen where you can choose a pdf templet to print on and choose how many labels you want to print and from which label on the sheet you would like printing from.\n"""),
                Text("""The layout of this screen has the barcode on top. Then explains what to do on the screen.  The first option you will get is the drop down menu to choose a pdf templet to print on(Please note all current pdf templets is A4 size).\n\nThe next option is a textfield to type in a amount of labels you would like to print and the last textfield is from which label you would like to print.  Then you can tap the Create pdf button to create the templet to print.\n"""),
                Text("""The last button, 'pick labels' give you the option to use checkboxes to choose how many labels you would like to print and and which labels on the sheet you would like to print.(Please note you still have to choose the templet from the drop down list before you can use this option.\n"""),
                Text("""On this screen after choosing how many labels and where on the  sheet you wish to print, at the top on the right you will find a 'share' button to create the  pdf template to send to your email to print.\n\n"""),
                Semantics(
                  header: true,
                  child: Text("""PRODUCT LIST BUTTON:""", style: TextStyle(
        //color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 40)) //HeadingWidget())
                ),
                Text("""On this screen you will get a list of products/items saved to your device. You can choose any of the items by double clicking on it.  It then will open a 'edit page' screen.\n"""),
                Text("""This screen has a text field showing the barcode/qr code type and the barcode.  Then it has a text field with the product/item name where you can edit or change the name should you need to.\n"""),
                Text("""Then it has 6 buttons. 'CANCEL' will take you back to the product list screen. 'SAVE' lets you save the product if you have made any changes to the name. 'SEARCH WEB' if you wish to search the web for the product. 'DELETE' to delete the product/item from the device. 'DELETE ALL' deletes all saved products/items saved to the device. 'CREATE PDF' will take you to the next screen where you can choose a pdf templet to print on and choose how many labels you want to print and from which label on the sheet you would like to startprinting from.\n"""),
                Text("""The layout of this screen has the barcode on top. Then explains what to do on the screen.  The first option you will get is the drop down menu to choose a pdf templet to print on(Please note all current pdf templets is A4 size).\n\nThe next option is a textfield to type in a amount of labels you would like to print and the last textfield is from which label you would like to print.  Then you can tap the Create pdf button to create the templet to print.\n\nThe last button, 'pick labels' give you the option to use checkboxes to choose how many labels you would like to print and and which labels on the sheet you would like to print.(Please note you still have to choose the templet from the drop down list before you can use this option.\n"""),
                Text("""On this screen after choosing how many labels and where on the  sheet you wish to print, at the top on the right you will find a 'share' button to create the  pdf template to send to your email or to print.\n\n"""),
                Semantics(
                  header: true,
                  child: Text("""USER GUIDE BUTTON:""", style: TextStyle(
        //color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 40)) //HeadingWidget())
                ),
                Text("""This is where you are currently to give you a idea how to use the app and also have the licenses and contact details for feedback and suggestions.\n\n"""),
                Semantics(
                  header: true,
                  child: Text("""ABOUT BUTTON:""", style: TextStyle(
        //color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 40)) //HeadingWidget())
                ),
                Text("""This will give you information on what the Uno Accessibility suite is about and what other apps are in the process to be developed.\n"""),
                Semantics(
                  header: true,
                  child: Text("""CONTACT DETAILS:""", style: TextStyle(
        //color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 40)) //HeadingWidget())
                ),
                Text("""You can double tap on the email to open your email app to send me a email or double tap on the phone number to open your dialing app to call me.\n"""),
                Text("""Developer: Hendrik Lubbe"""),
                GestureDetector(
                  child: Text("""Email:  blindguydiy@gmail.com<mailto:blindguydiy@gmail.com>"""),
                  onTap: () {
                    setState(() {
                      _contactMe(        Uri.encodeFull('mailto:blindguydiy@gmail.com?subject=Uno Barcode Reader Response')); 
                    }); // setstate
                  } // ontap
                ), // gesture detector
                GestureDetector(
                  child: Text("""Contact number:  +27795235842"""),
                  onTap: () {
                    setState(() {
                      _contactMe("tel:+27795235842");
                    }); // setstate
                  } // ontap
                ), // gesture detector
              ], // column widget
            ), // column

          ), // single scroll child
        ), // container
        style: TextStyle(color: Colors.white),
      ), // body DefaultTextStyle
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

  void _contactMe(String url) async {
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw "Could not launch $url";
    }
  }


} //class