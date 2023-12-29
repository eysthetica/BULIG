import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kantinir_mobile_app/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../food_page/foodPage.dart';
import '../housing_page/housingPage.dart';
import 'foodEstablishment.dart';

class foodEstablishmentPage extends StatefulWidget {
  final DocumentSnapshot records;
  foodEstablishmentPage({required this.records});
  @override
  State<foodEstablishmentPage> createState() => _foodEstablishmentPageState();
}

class _foodEstablishmentPageState extends State<foodEstablishmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(widget.records["name"],
              style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Opens on: " +
                widget.records["open time"].toString() +
                "\n Closes on:" +
                widget.records["close time"].toString() +
                "\n Location: " +
                widget.records["location"] +
                "\n FB Link: " +
                widget.records["fb link"] +
                "\n Gcash: " +
                widget.records["gcash"].toString(),
            style: TextStyle(fontSize: 20),
          ),
        ));
  }
}
