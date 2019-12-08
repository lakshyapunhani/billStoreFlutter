import 'package:billstore/common/apifunctions/httpRequest.dart';
import 'package:billstore/model/User.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';

import 'MainScreen.dart';
import 'Signup.dart';


class Login extends StatefulWidget
{
  @override
  State createState() => LoginState();
}

class LoginState extends State<Login>
{
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  ProgressDialog progressDialog;

  _handleMobileNumberSubmitted(String text)
  {
    __submitMobileNumber();
    mobileNumberController.clear();
    passwordController.clear();
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    mobileNumberController.dispose();
    super.dispose();
  }

  __submitMobileNumber()
  async {
    //progressDialog.show();
    var httpRequest = HttpRequest();

    String username = mobileNumberController.text;
    String password = passwordController.text;
    print("Mobile number : ${mobileNumberController.text}" + " Password : ${passwordController.text}");

    try
    {
      var result = await httpRequest.login(username, password);
      User user = User.fromJson(result);

      print("Email " + user.email + "Address " + user.address);

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
    progressDialog = new ProgressDialog(context);
    return new MaterialApp(
        home: Scaffold(body:
        SafeArea(child:
        Container(
            padding: EdgeInsets.all(10.0),
            child:SingleChildScrollView(
                child: Column(
                    children: <Widget>[
                      new Image(
                          image: AssetImage("assets/images/ic_login.png"),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.35,
                          alignment: AlignmentDirectional.center),

                      Container(
                        margin: EdgeInsets.all(18.0),
                        width: double.maxFinite,
                        child: Text("Welcome Back!",textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 24,color: Colors.black
                            )),
                      ),

                      Container(
                        margin: EdgeInsets.fromLTRB(18.0,20,0,10),
                        width: double.maxFinite,
                        child: Text("Mobile Number",textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 14,color: Colors.grey
                            )),
                      ),

                      Container(
                          margin: EdgeInsets.fromLTRB(18, 0, 0, 0),
                          width:double.maxFinite,
                          decoration: new BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              border: new Border.all(color: Colors.grey)
                          ),
                          child: TextField(controller: mobileNumberController,
                              onSubmitted: _handleMobileNumberSubmitted,
                              textAlign: TextAlign.start,
                              enabled: true,
                              keyboardType: TextInputType.number,
                              decoration:
                              new InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter your mobile number",
                                  contentPadding: const EdgeInsets.all(13.0)))),

                      Container(
                        margin: EdgeInsets.fromLTRB(18,20,0,10),
                        width: double.maxFinite,
                        child: Text("Password",textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 14,color: Colors.grey
                            )),
                      ),

                      Container(
                          margin: EdgeInsets.fromLTRB(18, 0, 0, 0),
                          width:double.maxFinite,
                          decoration: new BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              border: new Border.all(color: Colors.grey)
                          ),
                          child: TextField(controller: passwordController,
                              onSubmitted: _handleMobileNumberSubmitted,
                              textAlign: TextAlign.start,
                              enabled: true,
                              obscureText: true,
                              decoration:
                              new InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter your password",
                                  contentPadding: const EdgeInsets.all(13.0)))),

                      Container(
                        margin: EdgeInsets.fromLTRB(18, 30, 0, 0),
                        width: double.maxFinite,
                        child: RaisedButton(
                            padding: EdgeInsets.all(20),
                            onPressed: __submitMobileNumber,
                            shape:RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                            child :
                            Text("Login"),
                            color: Color(0xff5A55F4),
                            textColor: Colors.white),
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(18.0,20,0,10),
                          width: double.maxFinite,
                          child: InkWell(
                              onTap:()
                              {
                                Navigator.push(context, MaterialPageRoute(builder:
                                    (context) => Signup()));},
                              child: Text("Don't have an account? Create an Account",textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14,color: Color(0xff5A55F4)
                                  )))
                      ),


                    ]))
        )))

    );
  }

}