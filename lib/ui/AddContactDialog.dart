import 'dart:async';

import 'package:billstore/common/httpRequest.dart';
import 'package:billstore/model/Contact.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class AddContactDialog extends StatefulWidget {

  final Contact contact;

  AddContactDialog({Key key, this.contact}) : super(key:key);

  @override
  AddContactDialogState createState() => AddContactDialogState();
}

class AddContactDialogState extends State<AddContactDialog> {
  bool _saveNeeded = false;
  bool _hasUsername = false;
  bool _hasName = false;
  String _contactName;
  String _contactAddress;
  String _contactEmail;
  String _contactUsername;
  String _contactGstNumber;

  int id = 0;

  TextEditingController contactNameEditingController = TextEditingController();
  TextEditingController contactAddressEditingController = TextEditingController();
  TextEditingController contactEmailEditingController = TextEditingController();
  TextEditingController contactUsernameEditingController = TextEditingController();
  TextEditingController contactGstNumberEditingController = TextEditingController();

  var appBarTitle = "Add Client";


  @override
  void initState() {
    if(widget.contact != null)
    {
      appBarTitle = "Edit Client";
      id = widget.contact.id;
      contactNameEditingController.text = widget.contact.name;
      contactAddressEditingController.text = widget.contact.address;
      contactUsernameEditingController.text = widget.contact.username;
      contactEmailEditingController.text = widget.contact.email;
      contactGstNumberEditingController.text = widget.contact.gstNumber;
      _contactName = widget.contact.name;
      _contactAddress = widget.contact.address;
      _contactEmail = widget.contact.email;
      _contactUsername = widget.contact.username;
      _contactGstNumber = widget.contact.gstNumber;
    }
  }

  Future<bool> _onWillPop() async {
    _saveNeeded = _hasUsername || _hasName || _saveNeeded;
    if (!_saveNeeded)
      return true;

    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle = theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);

    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            'Discard product?',
            style: dialogTextStyle,
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop(false); // Pops the confirmation dialog but not the page.
              },
            ),
            FlatButton(
              child: const Text('DISCARD'),
              onPressed: () {
                Navigator.of(context).pop(true); // Returning true to _onWillPop will pop again.
              },
            ),
          ],
        );
      },
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        actions: <Widget> [
          FlatButton(
            child: Text('SAVE', style:
            theme.textTheme.body1.copyWith(color: Colors.white)),
            onPressed: () async {
              var httpRequest = HttpRequest();

              if(id == 0)
              {
                try
                {
                  await httpRequest.addClient(_contactName,_contactUsername,
                      _contactAddress,_contactEmail,_contactGstNumber);
                  Navigator.pop(context);
                }
                catch(e)
                {
                  Toast.show("Something went wrong.", context);
                }
              }
              else
              {
                try
                {
                  await httpRequest.updateClient(id.toString(),_contactName,_contactUsername,
                      _contactAddress,_contactEmail,_contactGstNumber);
                  Navigator.pop(context);
                }
                catch(e)
                {
                  Toast.show("Something went wrong.", context);
                }
              }
            },
          ),
        ],
      ),
      body: Form(
        onWillPop: _onWillPop,
        child: Scrollbar(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                alignment: Alignment.bottomLeft,
                child: TextField(
                  controller: contactNameEditingController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    filled: true,
                  ),
//                  style: theme.textTheme.headline,
                  onChanged: (String value) {
                    setState(() {
                      _hasName = value.isNotEmpty;
                      if (_hasName) {
                        _contactName = value;
                      }
                    });
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                alignment: Alignment.bottomLeft,
                child: TextField(
                  controller: contactAddressEditingController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    hintText: 'What is contact address?',
                    filled: true,
                  ),
                  onChanged: (String value) {
                    setState(() {
                      _contactAddress = value;
                    });
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                alignment: Alignment.bottomLeft,
                child: TextField(
                  controller: contactUsernameEditingController,
                  decoration: const InputDecoration(
                    labelText: 'Mobile number',
                    hintText: 'What is contact mobile number?',
                    filled: true,
                  ),
                  onChanged: (String value) {
                    setState(() {
                      _hasUsername = value.isNotEmpty;
                      _contactUsername = value;
                    });
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                alignment: Alignment.bottomLeft,
                child: TextField(
                  controller: contactEmailEditingController,
                  decoration: const InputDecoration(
                    labelText: 'Email Id',
                    hintText: 'What is contact email id?',
                    filled: true,
                  ),
                  onChanged: (String value) {
                    setState(() {
                      _contactEmail = value;
                    });
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                alignment: Alignment.bottomLeft,
                child: TextField(
                  controller: contactGstNumberEditingController,
                  decoration: const InputDecoration(
                    labelText: 'GST Number',
                    hintText: 'What is contact gst number?',
                    filled: true,
                  ),
                  onChanged: (String value) {
                    setState(() {
                      _contactGstNumber = value;
                    });
                  },
                ),
              ),
            ]
                .map<Widget>((Widget child) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                height: 96.0,
                child: child,
              );
            })
                .toList(),
          ),
        ),
      ),
    );
  }
}