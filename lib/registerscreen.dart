import 'package:flutter/material.dart';
import 'package:pocketdoctor/loginscreen.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

void main() => runApp(RegisterScreen());
class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isChecked = false;
  double screenHeight;
  String urlRegister = ("https://pdoc1.000webhostapp.com/register.php");
  TextEditingController _nameTxtController = new TextEditingController();
  TextEditingController _emailTxtController = new TextEditingController();
  TextEditingController _phoneTxtController = new TextEditingController();
  TextEditingController _passTxtController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: Stack(
            children: <Widget>[
              registerBody(context),
              pageTitle()
            ],
          )),
    );
  }

  Widget registerBody(BuildContext context) {
    return Container(
      height: 400,
      margin: EdgeInsets.only(top: screenHeight / 3.5),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: <Widget>[
          Card(
            elevation: 10,
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextFormField(
                      controller: _nameTxtController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        icon: Icon(Icons.person),
                      )),
                  TextField(
                      controller: _emailTxtController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        icon: Icon(Icons.email),
                      )),
                  TextField(
                      controller: _phoneTxtController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Mobile',
                        icon: Icon(Icons.phone),
                      )),
                  TextField(
                    controller: _passTxtController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      icon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Checkbox(
                        value: _isChecked,
                        onChanged: (bool value) {
                          _onChange(value);
                        },
                      ),
                      GestureDetector(
                        onTap: _showEULA,
                        child: Text('I Agree to Terms  ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        minWidth: 115,
                        height: 40,
                        child: Text('Register'),
                        color: Colors.green,
                        textColor: Colors.white,
                        elevation: 10,
                        onPressed: _onRegister,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Already register? ", style: TextStyle(fontSize: 16.0)),
              GestureDetector(
                onTap: _loginScreen,
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget pageTitle() {
    return Container(
      //color: Color.fromRGBO(255, 200, 200, 200),
      margin: EdgeInsets.only(top: 60),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            " Pocket Doctor ",
            style: TextStyle(
                fontSize: 36, color: Colors.green, fontWeight: FontWeight.w900),
          )
        ],
      ),
    );
  }

  void _onRegister() {
    String name = _nameTxtController.text;
    String email = _emailTxtController.text;
    String phone = _phoneTxtController.text;
    String password = _passTxtController.text;

    http.post(urlRegister, body: {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
    }).then((res) {
      if (res.body == "success") {
        Navigator.pop(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => LoginScreen()));
        Toast.show("Registration success", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      } else {
        Toast.show("Registration failed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }).catchError((err) {
      print(err);
    });
  }

  void _loginScreen() {
    Navigator.pop(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
  }

  void _showEULA() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("EULA"),
          content: new Container(
            height: screenHeight / 2,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: new SingleChildScrollView(
                    child: RichText(
                        softWrap: true,
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              //fontWeight: FontWeight.w500,
                              fontSize: 12.0,
                            ),
                            text:
                                "By agreeing to this T&C you are not allowed to violate any rules stated by PocketDoctor. Using this application for undesignated purpose is liable."
                            //children: getSpan(),
                            )),
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void _onChange(bool value) {
    setState(() {
      _isChecked = value;
      //savepref(value);
    });
  }

}
