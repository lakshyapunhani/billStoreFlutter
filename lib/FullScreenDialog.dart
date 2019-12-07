import 'dart:async';

import 'package:flutter/material.dart';

enum DismissDialogAction {
  cancel,
  discard,
  save,
}

class FullScreenDialogDemo extends StatefulWidget {
  @override
  FullScreenDialogDemoState createState() => FullScreenDialogDemoState();
}

class FullScreenDialogDemoState extends State<FullScreenDialogDemo> {
  bool _allDayValue = false;
  bool _saveNeeded = false;
  bool _hasLocation = false;
  bool _hasName = false;
  String _eventName;

  Future<bool> _onWillPop() async {
    _saveNeeded = _hasLocation || _hasName || _saveNeeded;
    if (!_saveNeeded)
      return true;

    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle = theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);

    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            'Discard new event?',
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
            child: Text('SAVE', style: theme.textTheme.body1.copyWith(color: Colors.white)),
            onPressed: () {
              Navigator.pop(context, DismissDialogAction.save);
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
                    labelText: 'Event name',
                    filled: true,
                  ),
                  style: theme.textTheme.headline,
                  onChanged: (String value) {
                    setState(() {
                      _hasName = value.isNotEmpty;
                      if (_hasName) {
                        _eventName = value;
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
                    labelText: 'Location',
                    hintText: 'Where is the event?',
                    filled: true,
                  ),
                  onChanged: (String value) {
                    setState(() {
                      _hasLocation = value.isNotEmpty;
                    });
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: theme.dividerColor))
                ),
                child: Row(
                  children: <Widget> [
                    Checkbox(
                      value: _allDayValue,
                      onChanged: (bool value) {
                        setState(() {
                          _allDayValue = value;
                          _saveNeeded = true;
                        });
                      },
                    ),
                    const Text('All-day'),
                  ],
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