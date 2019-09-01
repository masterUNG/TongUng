import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tong_ung/models/product_model.dart';
import 'package:tong_ung/screens/detail.dart';
import 'package:tong_ung/screens/home.dart';
import 'package:tong_ung/screens/my_style.dart';
import 'package:tong_ung/screens/show_list_produce.dart';
import 'package:tong_ung/screens/show_map.dart';
import 'package:barcode_scan/barcode_scan.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // Explicit
  String nameLogin = '';
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Widget myWidget = ShowListProduct();
  String qrCode = '';
  List<ProductModel> productModels = [];

  // Method
  @override
  void initState() {
    super.initState();
    findDisplayName();
    readProduct();
  }

  Future<void> readProduct() async {
    Firestore firestore = Firestore.instance;
    CollectionReference collectionReference = firestore.collection('Product');
    await collectionReference.snapshots().listen((response) {
      List<DocumentSnapshot> snapshots = response.documents;
      for (var snapshot in snapshots) {
        ProductModel productModel = ProductModel(
            snapshot.data['Name'],
            snapshot.data['Detail'],
            snapshot.data['Path'],
            snapshot.data['QRcode']);
        productModels.add(productModel);
      }
    });
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
      onTap: () {
        setState(() {
          myWidget = ShowListProduct();
          Navigator.of(context).pop();
        });
      },
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
      onTap: () {
        setState(() {
          myWidget = ShowMap();
          Navigator.of(context).pop();
        });
      },
    );
  }

  Widget showReadQRmenu() {
    return ListTile(
      leading: Icon(
        Icons.android,
        size: 36.0,
        color: Colors.green,
      ),
      title: Text('Read QR code'),
      subtitle: Text('Read Product by QR code or Bar code'),
      onTap: () {
        processReadQRcode();
        Navigator.of(context).pop();
      },
    );
  }

  Future<void> processReadQRcode() async {
    try {
      qrCode = await BarcodeScanner.scan();
      print('qrCode = $qrCode');

      for (var productModel in productModels) {
        if (qrCode == productModel.qrCode) {
          MaterialPageRoute materialPageRoute = MaterialPageRoute(
              builder: (BuildContext context) => Detail(
                    productModel: productModel,
                  ));
          Navigator.of(context).push(materialPageRoute);
        }
      }
    } catch (e) {}
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
      onTap: () {
        processSignOut();
      },
    );
  }

  Future<void> processSignOut() async {
    await firebaseAuth.signOut().then((response) {
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => Home());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    });
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
          showReadQRmenu(),
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
        backgroundColor: MyStyle().textColor,
        title: Text('My Service'),
      ),
      body: myWidget,
      drawer: menuDrawer(),
    );
  }
}
