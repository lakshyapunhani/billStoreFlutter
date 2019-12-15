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

  @override
  void initState(){
    getContacts();
  }

  getContacts() async{
    try{
      var httpRequest = HttpRequest();
      var response = await httpRequest.getAllClients();

      _contacts.clear();
      for (var i = 0; i < response.length; i++) {
        this._contacts.add(Contact.fromJson(response[i]));
      }
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
      ListView.builder(
        itemBuilder: (context, position) {
          return InkWell(onTap: () async {
            var result = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddContactDialog(contact: _contacts[position])));
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
      ),
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

}