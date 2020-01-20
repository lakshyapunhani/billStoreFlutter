import 'package:billstore/common/httpRequest.dart';
import 'package:billstore/model/Estimate.dart';
import 'package:billstore/model/Product.dart';
import 'package:flutter/material.dart';

import 'AddProductDialog.dart';

class EstimateScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => EstimateState();
}

class EstimateState extends State<EstimateScreen>
{
  List<Estimate> _estimates = <Estimate>[];
  List<Estimate> _queryEstimates = <Estimate>[];

  @override
  void initState(){
    getEstimates();
  }

  getEstimates() async{
    try{
      var httpRequest = HttpRequest();
      var response = await httpRequest.getAllEstimates();

      _estimates.clear();
      _queryEstimates.clear();
      for (var i = 0; i < response.length; i++) {
        this._estimates.add(Estimate.fromJson(response[i]));
      }
      this._queryEstimates.addAll(_estimates);
    }
    catch(e) {
      print(e);
    }

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
      appBar: AppBar(title: Text("Estimates")),
      body:
      Container(
          child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    onChanged: (value) {
                      filterSearchResults(value);
                    },
                    decoration: InputDecoration(
                        labelText: "Search",
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)))),
                  ),
                ),
                Expanded(
                    child:
                    ListView.builder(
                      itemBuilder: (context, position) {
                        return InkWell(onTap: () async {
//                          var result = await Navigator.push(context,
//                              MaterialPageRoute(builder: (context) =>
//                                  AddProductDialog(product: _products[position],)));
                          getEstimates();
                        }, child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                                      child: Text(
                                        _estimates[position].contact.name,
                                        style: TextStyle(
                                            fontSize: 22.0, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                                      child: Text(
                                        _estimates[position].invoiceNumber,
                                        style: TextStyle(fontSize: 18.0),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(
                                        "INR " +_estimates[position].total.toString(),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 2.0,
                              color: Colors.grey,
                            )
                          ],
                        ));
                      },
                      itemCount: _estimates.length,
                    ))])),
      floatingActionButton:
      FloatingActionButton(onPressed: () async
      {
//        var result = await Navigator.push(context,
//            MaterialPageRoute(builder: (context) => AddProductDialog()));
        getEstimates();
      },
        child: new IconTheme(
          data: new IconThemeData(
              color: Colors.white),
          child: new Icon(Icons.add),
        ),),),);
  }

  void filterSearchResults(String query) {
    List<Estimate> dummySearchList = List<Estimate>();
    dummySearchList.addAll(_estimates);
    if(query.isNotEmpty) {
      List<Estimate> dummyListData = List<Estimate>();
      dummySearchList.forEach((item) {
        if(item.invoiceNumber.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        _estimates.clear();
        _estimates.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        _estimates.clear();
        _estimates.addAll(_queryEstimates);
      });
    }
  }
}