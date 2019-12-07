import 'package:flutter/material.dart';

class Signup extends StatefulWidget
{

  @override
  State createState() => new SignupState();
}

class SignupState extends State<Signup>
{

  __submitMobileNumber()
  {
    print("Mobile number : ");
  }

  @override
  Widget build(BuildContext context)
  {
    return new MaterialApp(
        home: Scaffold(
            body: SafeArea(child:Center(child:
            SingleChildScrollView(padding: EdgeInsets.all(10.0),
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(child:
                      Text("Sign up", style:
                      TextStyle(fontSize: 30,color: Color(0xff5A55F4)),textAlign: TextAlign.start),width: double.infinity,padding: EdgeInsets.all(20.0)),
                      Container(padding:EdgeInsets.all(10),child:
                      TextFormField(decoration:
                      InputDecoration(
                          border: UnderlineInputBorder(),
                          filled: false,
                          icon: Icon(Icons.person),
                          labelText: "Company name *"))),
                      Container(padding:EdgeInsets.all(10),child:
                      TextFormField(decoration:
                      InputDecoration(
                          border: UnderlineInputBorder(),
                          filled: false,
                          icon: Icon(Icons.home),
                          labelText: "Company address *",))),
                      Container(padding:EdgeInsets.all(10),child:
                      TextFormField(decoration:
                      InputDecoration(
                          border: UnderlineInputBorder(),
                          filled: false,
                          icon: Icon(Icons.person),
                          labelText: "Company GST *",))),
                      Container(padding:EdgeInsets.all(10),child:
                      TextFormField(decoration:
                      InputDecoration(
                          border: UnderlineInputBorder(),
                          filled: false,
                          icon: Icon(Icons.person),
                          labelText: "Mobile Number/Username *"))),
                      Container(padding:EdgeInsets.all(10),child:
                      TextFormField(
                          obscureText:true,
                          decoration:
                          InputDecoration(
                              border: UnderlineInputBorder(),
                              filled: false,
                              icon: Icon(Icons.person),
                              labelText: "Password *"))),
                      Container(
                        margin: EdgeInsets.fromLTRB(18, 30, 0, 0),
                        width: double.maxFinite,
                        child: RaisedButton(
                            padding: EdgeInsets.all(20),
                            onPressed: __submitMobileNumber,
                            shape:RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                            child :
                            Text("SUBMIT"),
                            color: Color(0xff5A55F4),
                            textColor: Colors.white),
                      ),
                    ]))))));
  }

}