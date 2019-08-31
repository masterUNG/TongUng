import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // Explicit
  String nameLogin = '';
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Method
  @override
  void initState() {
    super.initState();
    findDisplayName();
  }

  Future<void> findDisplayName() async {
    await firebaseAuth.currentUser().then((response) {
      setState(() {
        nameLogin = response.displayName;
        print('nameLogin = $nameLogin');
      });
    });
  }

  Widget myDivider() {
    return Divider();
  }

  Widget showListProductMenu() {
    return ListTile(
      leading: Icon(
        Icons.home,
        size: 36.0,
        color: Colors.blue.shade700,
      ),
      title: Text('Show List Product'),
      subtitle: Text('Page Show All ListView Product'),
    );
  }

  Widget showMapMenu() {
    return ListTile(
      leading: Icon(
        Icons.map,
        size: 36.0,
        color: Colors.yellow.shade600,
      ),
      title: Text('Show Map'),
      subtitle: Text('Page Show Map and Your Location'),
    );
  }

  Widget showSignOutMenu() {
    return ListTile(
      leading: Icon(
        Icons.exit_to_app,
        size: 36.0,
        color: Colors.red.shade700,
      ),
      title: Text('Sign Out'),
      subtitle: Text('Sign Out Move to Home Page'),
    );
  }

  Widget showImage() {
    return Container(
      height: 80.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showAppName() {
    return Text(
      'Tong Ung',
      style: TextStyle(fontSize: 24.0),
    );
  }

  Widget showNameLogin() {
    return Text(
      'Login by $nameLogin',
      style: TextStyle(color: Colors.pink),
    );
  }

  Widget myHeadDrawer() {
    return DrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              'images/wallpaper.jpg',
            ),
            fit: BoxFit.cover),
      ),
      child: Column(
        children: <Widget>[
          showImage(),
          showAppName(),
          showNameLogin(),
        ],
      ),
    );
  }

  Widget menuDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          myHeadDrawer(),
          showListProductMenu(),
          myDivider(),
          showMapMenu(),
          myDivider(),
          showSignOutMenu(),
          myDivider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Service'),
      ),
      body: Text('body'),
      drawer: menuDrawer(),
    );
  }
}
