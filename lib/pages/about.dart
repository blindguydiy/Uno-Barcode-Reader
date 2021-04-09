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

// import packages
import 'package:flutter/material.dart';

class about extends StatefulWidget {

  @override
  _aboutState createState() => _aboutState();

}

class _aboutState extends State<about> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("About Uno Accessibility Suite"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text("Uno Accessability Suite"),
              Text(''),
              Text("This suite was developed for the use by blind users in mind.  The name is derived 'Uno', my first and only guide dog that retired. On the home page there is a pic of him."),
              Text(''),
              Text('I decided to develop this suite for some of the features I wanted to use was not available in current apps available.  Also I believe that most apps that can be runh straight from the device should be free for blind users and not be charged to be able  to do what  other people can do for free.'),
              Text(''),
              Text('So this will be my small contribution should these apps be usefull to anyone else, and should anyone be interested in contributing to this project they are more than welcome.  Contributions can be from donations, programmers that want to contribute to the project to speed it up or even in some cases taking pictures or cropping pictures/images for training the neural networks for image classification and object detection. Feel free to contact me anytime to find out if you can contribute and if you have any ideas for other apps not available in the list below.  I will Definitely listen to all ideas.'),
              Text(''),
              Text('The following apps is so far in the list for the Uno accessibility Suite.'),
              Text(''),
              Text('1.  Uno Barcode Reader - (On play store in alfa version for testing.  You can go to the userguide page to read how to use),'),
              Text('2.  Uno Cash Reader - (Currently in development.  Will only identify South African Rand and Namibian dollar for now),'),
              Text('3.  Uno Object detection - (In planning),'),
              Text('4.  Uno Text Reader - (In planning. Will be a text reader with finger point and read),'),
              Text('5.  Uno Face Detection - (In planning).'),
              Text(''),
              Text('You are welcome to contact me if you require more information or have any suggestions.'),
              Text(''),
              Text('CONTACT DETAILS:'),
              Text(''),
              Text('Developer: Hendrik Lubbe'),
              Text('Email:  blindguydiy@gmail.com'),
              Text('Whatsapp or Call:  27795235842'),
            ], // column widget
          ), // column
        ), // single child scroll
      ),  // body container
    );  // scaffold
  }  // build widget

}
