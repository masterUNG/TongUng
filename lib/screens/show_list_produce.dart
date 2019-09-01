import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tong_ung/models/product_model.dart';
import 'package:tong_ung/screens/my_style.dart';

class ShowListProduct extends StatefulWidget {
  @override
  _ShowListProductState createState() => _ShowListProductState();
}

class _ShowListProductState extends State<ShowListProduct> {
  // Explicit
  List<ProductModel> productModels = [];

  // Method
  @override
  void initState() {
    super.initState();
    readFireStore();
  }

  Future<void> readFireStore() async {
    Firestore firestore = Firestore.instance;
    CollectionReference collectionReference = firestore.collection('Product');

    await collectionReference.snapshots().listen((response) {
      List<DocumentSnapshot> snapshots = response.documents;
      for (var snapshot in snapshots) {
        // String name = snapshot.data['Name'];
        // print('name = $name');

        ProductModel productModel = ProductModel(snapshot.data['Name'],
            snapshot.data['Detail'], snapshot.data['Path']);
        setState(() {
          productModels.add(productModel);
        });
      }
    });
  }

  Widget showListViewProduct() {
    return ListView.builder(
      itemCount: productModels.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: index % 2 == 0
              ? BoxDecoration(color: Colors.blue.shade100)
              : BoxDecoration(color: Colors.blue.shade400),
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width * 0.5,
                child: Image.network(
                  productModels[index].path,
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.5,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        productModels[index].name,
                        style: TextStyle(fontSize: MyStyle().h1),
                      ),
                    ),
                    Text(makeShortDetail(productModels[index].detail), style: index % 2 == 0 ? TextStyle(color: MyStyle().textColor) : TextStyle(color: MyStyle().whieteText),)
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  String makeShortDetail(String detail) {
    String myDetail = detail;
    if (myDetail.length > 50) {
      myDetail = myDetail.substring(0, 50);
      myDetail = '$myDetail ...';
    }
    return myDetail;
  }

  @override
  Widget build(BuildContext context) {
    return showListViewProduct();
  }
}
