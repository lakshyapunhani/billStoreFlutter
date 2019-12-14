import 'dart:async';

import 'package:billstore/common/httpRequest.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';



class AddProductDialog extends StatefulWidget {
  @override
  AddProductDialogState createState() => AddProductDialogState();
}

class AddProductDialogState extends State<AddProductDialog> {
  bool _saveNeeded = false;
  bool _hasDescription = false;
  bool _hasName = false;
  String _productName;
  String _productDescription;
  String _productRate;

  Future<bool> _onWillPop() async {
    _saveNeeded = _hasDescription || _hasName || _saveNeeded;
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
        title: Text('Add Product'),
        actions: <Widget> [
          FlatButton(
            child: Text('SAVE', style:
            theme.textTheme.body1.copyWith(color: Colors.white)),
            onPressed: () async {
              var httpRequest = HttpRequest();
              try
              {
                await httpRequest.addProduct(_productName, _productDescription, _productRate);
                Navigator.pop(context);
              }
              catch(e)
              {
                Toast.show("Something went wrong.", context);
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
                  decoration: const InputDecoration(
                    labelText: 'Product name',
                    filled: true,
                  ),
//                  style: theme.textTheme.headline,
                  onChanged: (String value) {
                    setState(() {
                      _hasName = value.isNotEmpty;
                      if (_hasName) {
                        _productName = value;
                      }
                    });
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                alignment: Alignment.bottomLeft,
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'What is product like?',
                    filled: true,
                  ),
                  onChanged: (String value) {
                    setState(() {
                      _hasDescription = value.isNotEmpty;
                      _productDescription = value;
                    });
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                alignment: Alignment.bottomLeft,
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Rate',
                    hintText: 'What is product rate?',
                    filled: true,
                  ),
                  onChanged: (String value) {
                    setState(() {
                      _productRate = value;
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