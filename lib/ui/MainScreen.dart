import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'Products.dart';

class MainScreen extends StatefulWidget
{
  @override
  State createState() =>  MainScreenState();
}

class MainScreenState extends State<MainScreen>
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home:
    Scaffold(body:
    SafeArea(child:
    Column(children: <Widget>[
      Expanded(flex: 3,child: Text("Hello world"),),
      Expanded(flex: 5,child:
      Card(color: Colors.grey,margin: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),),
        elevation: 5.0,
        child:Container(child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(height: 120,width: 160,child:
                    InkWell(onTap:()
                        {Navigator.push(context, MaterialPageRoute(builder: (context) => Products()));}, child:
                         Card(color: Colors.blue,shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),),
                            child:Center(child:
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image(
                                    image: AssetImage("assets/images/box.png"),
                                    width: 70,
                                    height: 70,
                                    alignment: AlignmentDirectional.center),
                                  Padding(padding: EdgeInsets.all(5.0),),
                                  Text("Invoices",
                                  style: TextStyle(color: Colors.white))]))),)),
                Container(height: 120,width: 160,child:
                Card(color: Colors.blue,semanticContainer: true,shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),),
                    child:Center(child:
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(
                              image: AssetImage("assets/images/box.png"),
                              width: 70,
                              height: 70,
                              alignment: AlignmentDirectional.center),
                          Padding(padding: EdgeInsets.all(5.0),),
                          Text("Estimates",
                              style: TextStyle(color: Colors.white))
                        ]))))
              ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(height: 120,width: 160,child:
                Card(color: Colors.blue,shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),),
                    child:Center(child:
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(
                              image: AssetImage("assets/images/box.png"),
                              width: 70,
                              height: 70,
                              alignment: AlignmentDirectional.center),
                          Padding(padding: EdgeInsets.all(5.0),),
                          Text("Products",
                              style: TextStyle(color: Colors.white))
                        ])))),
                Container(height: 120,width: 160,child:
                Card(color: Colors.blue,semanticContainer: true,shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),),
                    child:Center(child:
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(
                              image: AssetImage("assets/images/box.png"),
                              width: 70,
                              height: 70,
                              alignment: AlignmentDirectional.center),
                          Padding(padding: EdgeInsets.all(5.0),),
                          Text("Clients",
                              style: TextStyle(color: Colors.white))
                        ]))))
              ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(height: 120,width: 160,child:
                Card(color: Colors.blue,semanticContainer: true,shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),),
                    child:Center(child:
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(
                              image: AssetImage("assets/images/box.png"),
                              width: 70,
                              height: 70,
                              alignment: AlignmentDirectional.center),
                          Padding(padding: EdgeInsets.all(5.0),),
                          Text("Reports",
                              style: TextStyle(color: Colors.white))
                        ])))),
                Container(height: 120,width: 160,child:
                Card(color: Colors.blue,semanticContainer: true,shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),),
                    child:Center(child:
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(
                              image: AssetImage("assets/images/box.png"),
                              width: 70,
                              height: 70,
                              alignment: AlignmentDirectional.center),
                          Padding(padding: EdgeInsets.all(5.0),),
                          Text("Settings",
                              style: TextStyle(color: Colors.white))
                        ]))))
              ],)
          ],),),),),],)
    )));
  }

}