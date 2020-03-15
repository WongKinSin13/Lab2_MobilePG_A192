import 'package:flutter/material.dart';
import 'package:pocketdoctor/registerscreen.dart';

void main() => runApp(LoginScreen());
 
class LoginScreen extends StatefulWidget {
@override
_LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double screenHeight;
  //TextEditingController _emailTxtController = new TextEditingController();
  //TextEditingController _passTxtController = new TextEditingController();
  String urlLogin = "";

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: null,
      child: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: Stack(
            children: <Widget>[
              loginbody(context),
            ],
          )),
    );
  }
    
  Widget loginbody(BuildContext context){
  return Container(
    padding: EdgeInsets.all(70),
  child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
  Text("Login", style:new TextStyle(color:Colors.green, fontSize:40, fontWeight:FontWeight.bold)),
  Image.asset(
  'assets/images/pdlogo.png',
  scale: 3,
  ),

  TextField(
    decoration: InputDecoration(
      labelText: 'Email',
    )
  ),
  TextField(
    decoration: InputDecoration(
      labelText: 'Password',
    ),
    obscureText: true,
  ),
  SizedBox(
    height: 20,
  ),

RaisedButton(
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(15.0)),
child: Text('Login', style: new TextStyle(color: Colors.white, fontSize:20)),
onPressed: null,
),

SizedBox(
  height: 20,
),

Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Don't have an account? ", style: TextStyle(fontSize: 16.0)),
              GestureDetector(
                onTap: _registerUser,
                child: Text(
                  "Signup Here",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
]
  )
);
  }


  void _registerUser() {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => RegisterScreen()));
  }
}
  