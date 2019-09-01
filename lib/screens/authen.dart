import 'package:flutter/material.dart';
import 'package:tong_ung/screens/my_style.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Explicit
  Color textColor = MyStyle().textColor;

  // Method
  Widget emailText() {
    return Container(
      width: 300.0,
      padding: EdgeInsets.only(left: 30.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'Email :',
          labelStyle: TextStyle(color: textColor),
          hintText: 'you@email.com',
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: textColor)),
        ),
      ),
    );
  }

  Widget passwordText() {
    return Container(
      width: 300.0,
      padding: EdgeInsets.only(left: 30.0),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Password :',
          labelStyle: TextStyle(color: textColor),
          hintText: 'More 6 Charactor',
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: textColor)),
        ),
      ),
    );
  }

  Widget showAppName() {
    return Container(
      padding: EdgeInsets.only(left: 30.0),
      child: ListTile(
        leading: Container(
          width: 48.0,
          height: 48.0,
          child: Image.asset(
            'images/logo.png',
            fit: BoxFit.contain,
          ),
        ),
        title: Text(
          'Tong Ung',
          style: TextStyle(
            fontSize: MyStyle().h1,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }

  Widget showAuthen() {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [Colors.white, textColor],
          radius: 1.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          showAppName(),
          emailText(),
          passwordText(),
        ],
      ),
    );
  }

  Widget backButton() {
    return IconButton(
      icon: Icon(
        Icons.navigate_before,
        size: 36.0,
        color: MyStyle().whieteText,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            showAuthen(),
            backButton(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyStyle().whieteText,
        child: Icon(
          Icons.navigate_next,
          size: 36.0,
          color: textColor,
        ),
        onPressed: () {},
      ),
    );
  }
}
