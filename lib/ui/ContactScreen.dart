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

  @override
  void initState(){
    getContacts();
  }

  getContacts() async{
    try{
      var httpRequest = HttpRequest();
      var response = await httpRequest.getAllClients();

      _contacts.clear();
      _queryContacts.clear();
      for (var i = 0; i < response.length; i++) {
        this._contacts.add(Contact.fromJson(response[i]));
      }
      this._queryContacts.addAll(_contacts);
    }
    catch(e) {
      Toast.show("No Contacts exist", context);
    }

    setState(() {

    });
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
                  getContacts();
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
              itemCount: _contacts.length,
            ))])),
    floatingActionButton:
    FloatingActionButton(onPressed: () async
    {
    var result = await Navigator.push(context,
    MaterialPageRoute(builder: (context) => AddContactDialog()));
    getContacts();
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