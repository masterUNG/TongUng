import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tong_ung/screens/authen.dart';
import 'package:tong_ung/screens/my_service.dart';
import 'package:tong_ung/screens/register.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Explicit
  Color textColor = Colors.blue[700];

  // Method
  @override
  void initState() { 
    super.initState();
    checkStatus();
  }

  Future<void> checkStatus()async{

    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    if (firebaseUser != null) {
      MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context).pushAndRemoveUntil(materialPageRoute, (Route<dynamic> reoute) => false);
    }

  }


  Widget mySizeBox() {
    return SizedBox(
      width: 5.0,
      height: 10.0,
    );
  }

  Widget signUpButton() {
    return OutlineButton(
      borderSide: BorderSide(color: textColor),
      child: Text(
        'Sign Up',
        style: TextStyle(color: textColor),
      ),
      onPressed: () {
        print('You Click SignUp');

        MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext context) => Register());
        Navigator.of(context).push(materialPageRoute);
      },
    );
  }

  Widget signInButton() {
    return RaisedButton(
      color: textColor,
      child: Text(
        'Sign In',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext context) => Authen());
        Navigator.of(context).push(materialPageRoute);
      },
    );
  }

  Widget showButton() {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          signInButton(),
          mySizeBox(),
          signUpButton(),
        ],
      ),
    );
  }

  Widget showLogo() {
    return Container(
      width: 150.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showText() {
    return Text(
      'Tong Ung',
      style: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color: textColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/wallpaper.jpg'),fit: BoxFit.cover
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                showLogo(),
                mySizeBox(),
                showText(),
                showButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
