import 'package:billstore/ui/ContactScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:toast/toast.dart';

import 'ProductScreen.dart';
import 'ContactScreen.dart';

class MainScreen extends StatefulWidget
{
  @override
  State createState() =>  MainScreenState();
}

class MainScreenState extends State<MainScreen>
{
  List<String> _menuTitleList=["Invoices","Estimates",
    "Clients","Products","Reports","More"];

  void _onGridClicked(int index)
  {
    switch(index)
    {
      case 2:
        {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ContactScreen()));
          break;
        }
      case 3:
        {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProductScreen()));
          break;
        }
    }
  }

  @override
  Widget build(BuildContext context)
  {
    List<String> items = [
      "Item 1",
      "Item 2",
      "Item 3",
      "Item 4",
      "Item 5",
      "Item 6",
      "Item 7",
      "Item 8"
    ];

    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    final headerList = new ListView.builder(
      itemBuilder: (context, index) {

        EdgeInsets padding = index == 0?const EdgeInsets.only(
            left: 20.0, right: 10.0, top: 4.0, bottom: 30.0):const EdgeInsets.only(
            left: 10.0, right: 10.0, top: 4.0, bottom: 30.0);

        return new Padding(
          padding: padding,
          child:  Container(
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(10.0),
              color: Color(0x80f3f7ff),
              boxShadow: [
                new BoxShadow(
                    color: Colors.black.withAlpha(70),
                    offset: const Offset(3.0, 10.0),
                    blurRadius: 15.0)
              ],
              image: new DecorationImage(
                image: AssetImage("assets/images/box.png"),
              ),
            ),
            width: 300.0,
            child: new Stack(
              children: <Widget>[
                new Align(
                  alignment: Alignment.bottomCenter,
                  child: new Container(
                      decoration: new BoxDecoration(
                          color: const Color(0xFF273A48),
                          borderRadius: new BorderRadius.only(
                              bottomLeft: new Radius.circular(10.0),
                              bottomRight: new Radius.circular(10.0))),
                      height: 30.0,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Text(
                            '${items[index%items.length]}',
                            style: new TextStyle(color: Colors.white),
                          )
                        ],
                      )),
                )
              ],
            ),
          ),

        );
      },
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
    );

    return MaterialApp(home:
    Scaffold(
        backgroundColor: Color(0xff5d64fa)
        ,body:
    SafeArea(child:
    Column(children: <Widget>[

      Expanded(flex: 1,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>
            [
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0,0,0,0),
                child: Text("Bill Store",style:
                TextStyle(color: Colors.white,fontSize: 40,
                    fontWeight: FontWeight.w600)),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                width: 40,
                height: 40,
                child: Icon(Icons.notifications_none, size: 20,),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0x80f3f7ff)),
              ),
            ],)),

      Expanded(flex: 2,child: new Container(
          height: 300.0, width: _width, child: headerList)),

      Expanded(flex: 5,
          child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 3/2,
              padding: const EdgeInsets.all(14.0),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              children: _getTiles()
          ))
    ],)
    )));}

  List<Widget> _getTiles() {
    final List<Widget> tiles = <Widget>[];
    for (int i = 0; i < _menuTitleList.length; i++) {
      tiles.add(new GridTile(
          child: new InkResponse(
            enableFeedback: true,
            child: _getWidget(_menuTitleList[i]),
            onTap: () => _onGridClicked(i),
          )));
    }
    return tiles;
  }

  Widget _getWidget(String label)
  {
    return Center(
        child:Container(
          margin: EdgeInsets.all(3.0),
          child:
          Card(color: Color(0x80f3f7ff),
              shape:
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),),
              child:Center(child:
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                        image: AssetImage("assets/images/box.png"),
                        width: 50,
                        height: 50,
                        alignment: AlignmentDirectional.center),
                    Padding(padding: EdgeInsets.all(5.0),),
                    Text(label,
                        style: TextStyle(color: Colors.black))
                  ]))),));
  }
}