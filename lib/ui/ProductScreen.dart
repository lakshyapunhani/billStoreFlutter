import 'package:billstore/common/httpRequest.dart';
import 'package:billstore/model/Product.dart';
import 'package:flutter/material.dart';
import 'AddProductDialog.dart';

class ProductScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => ProductState();
}

class ProductState extends State<ProductScreen>
{
  List<Product> _products = <Product>[];

  @override
  void initState(){
    getProducts();
  }

  getProducts() async{
    try{
      var httpRequest = HttpRequest();
      var response = await httpRequest.getAllProducts();

      _products.clear();
      for (var i = 0; i < response.length; i++) {
        this._products.add(Product.fromJson(response[i]));
      }
    }
    catch(e) {
    }

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
      appBar: AppBar(title: Text("Products")),
      body:
    ListView.builder(
      itemBuilder: (context, position) {
        return InkWell(onTap: () async {
          var result = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddProductDialog(product: _products[position],)));
          getProducts();
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
                        _products[position].name,
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                      child: Text(
                        _products[position].description,
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
                        "INR " +_products[position].rate.toString(),
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
      itemCount: _products.length,
    ),
      floatingActionButton:
      FloatingActionButton(onPressed: () async
      {
        var result = await Navigator.push(context,
          MaterialPageRoute(builder: (context) => AddProductDialog()));
        getProducts();
        },
        child: new IconTheme(
          data: new IconThemeData(
              color: Colors.white),
          child: new Icon(Icons.add),
        ),),),);
  }

}