import 'package:billstore/common/SessionManager.dart';
import 'package:billstore/common/httpRequest.dart';
import 'package:billstore/model/User.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'MainScreen.dart';

class Signup extends StatefulWidget
{

  @override
  State createState() => new SignupState();
}

class SignupState extends State<Signup>
{
  final TextEditingController companyNameController = new TextEditingController();
  final TextEditingController companyAddressController = new TextEditingController();
  final TextEditingController companyGstController = new TextEditingController();
  final TextEditingController userNameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  __submitForm() async
  {

    var httpRequest = HttpRequest();

    if(companyNameController.text.isEmpty)
    {
      Toast.show("Company name cannot be empty", context);
      return;
    }

//    var map = Map<String,dynamic>();
//    map['name'] = companyNameController.text;
//    map['address'] = companyAddressController.text;
//    map['gstNumber'] = companyGstController.text;
//    map['username'] = userNameController.text;
//    map['password'] = passwordController.text;

    Toast.show("Company Name " + companyNameController.text, context);

    try
    {
      var result = await httpRequest.signUp
        (companyNameController.text,
        companyAddressController.text,
        companyGstController.text,
        userNameController.text,
        passwordController.text
      );
      User user = User.fromJson(result);
      print("Email " + user.email + "Address " + user.address);
      await saveUserDetails(user);
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
    }
    catch(e)
    {
      Toast.show("Some error occured. Please try again", context);
    }


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
                      TextFormField(controller: companyNameController,
                          decoration:
                          InputDecoration(
                              border: UnderlineInputBorder(),
                              filled: false,
                              icon: Icon(Icons.person),
                              labelText: "Company name *"))),
                      Container(padding:EdgeInsets.all(10),child:
                      TextFormField(
                          controller: companyAddressController,
                          decoration:
                          InputDecoration(
                            border: UnderlineInputBorder(),
                            filled: false,
                            icon: Icon(Icons.home),
                            labelText: "Company address *",))),
                      Container(padding:EdgeInsets.all(10),child:
                      TextFormField(
                          controller: companyGstController,
                          decoration:
                          InputDecoration(
                            border: UnderlineInputBorder(),
                            filled: false,
                            icon: Icon(Icons.person),
                            labelText: "Company GST *",))),
                      Container(padding:EdgeInsets.all(10),child:
                      TextFormField(
                          controller: userNameController,
                          decoration:
                          InputDecoration(
                              border: UnderlineInputBorder(),
                              filled: false,
                              icon: Icon(Icons.person),
                              labelText: "Mobile Number/Username *"))),
                      Container(padding:EdgeInsets.all(10),child:
                      TextFormField(
                          controller: passwordController,
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
                            onPressed: __submitForm,
                            shape:RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                            child :
                            Text("SUBMIT"),
                            color: Color(0xff5A55F4),
                            textColor: Colors.white),
                      ),
                    ]))))));
  }

}