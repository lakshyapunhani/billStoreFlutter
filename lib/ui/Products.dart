import 'package:flutter/material.dart';

import 'FullScreenDialog.dart';

class Products extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => ProductState();
}

class ProductState extends State<Products>
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(floatingActionButton:
      FloatingActionButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => FullScreenDialogDemo()));},
        child: new IconTheme(
          data: new IconThemeData(
              color: Colors.white),
          child: new Icon(Icons.add),
        ),),),);
  }

}