import 'dart:collection';

import 'package:billstore/common/httpRequest.dart';
import 'package:billstore/model/Contact.dart';
import 'package:billstore/ui/AddContactDialog.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ContactScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => ContactState();
}

class ContactState extends State<ContactScreen>
{
  List<Contact> _contacts = <Contact>[];
  List<Contact> _queryContacts = <Contact>[];
  var isLoading = false;
  ScrollController _scrollController = ScrollController();
  var pageNo;

  @override
  void initState(){
    pageNo = 0;
    getContacts(pageNo);
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if (!isLoading) {
          print("reached bottom");
          isLoading = !isLoading;
          pageNo++;
          getContacts(pageNo);
          // Perform event when user reach at the end of list (e.g. do Api call)
        }
      }
    });
//    getContacts();
  }

  getContacts(int pageNo) async{
    print(pageNo);
    try{
      var httpRequest = HttpRequest();
      //Map map = new HashMap<String,int>();

      List<String> keys = ['pageNo', 'pageSize'];
      List<String> values = [pageNo.toString(), '7'];
      Map<String, String> map = Map.fromIterables(keys, values);
      var response = await httpRequest.getAllClients(map);

      //_contacts.clear();
      //_queryContacts.clear();
      if(pageNo != 0)
      {
        isLoading = !isLoading;
      }
      for (var i = 0; i < response.length; i++) {
        this._contacts.add(Contact.fromJson(response[i]));
      }
      this._queryContacts.addAll(_contacts);
    }
    catch(e) {
      print(e);
      Toast.show("No Contacts exist", context);
    }

    setState(() {

    });
  }


  @override
  void dispose() {
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
      appBar: AppBar(title: Text("Clients")),
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
                          var result = await Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>
                                  AddContactDialog(contact: _contacts[position])));
                          getContacts(pageNo);
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
                                        _contacts[position].name,
                                        style: TextStyle(
                                            fontSize: 22.0, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                                      child: Text(
                                        _contacts[position].address,
                                        style: TextStyle(fontSize: 18.0),
                                      ),
                                    ),
                                  ],
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
                      controller: _scrollController,
                      itemCount: _contacts.length,
                    ))])),
      floatingActionButton:
      FloatingActionButton(onPressed: () async
      {
        var result = await Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddContactDialog()));
        pageNo = 0;
        getContacts(pageNo);
      },
        child: new IconTheme(
          data: new IconThemeData(
              color: Colors.white),
          child: new Icon(Icons.add),
        ),),),);
  }

  void filterSearchResults(String query) {
    List<Contact> dummySearchList = List<Contact>();
    dummySearchList.addAll(_contacts);
    if(query.isNotEmpty) {
      List<Contact> dummyListData = List<Contact>();
      dummySearchList.forEach((item) {
        if(item.name.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        _contacts.clear();
        _contacts.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        _contacts.clear();
        _contacts.addAll(_queryContacts);
      });
    }
  }

}