import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myresult/profiledetail.dart';
import 'package:myresult/result.dart';
import 'package:myresult/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
          child: Stack(
            children: <Widget>[
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            // mainAxisSize: MainAxisSize.max,
            children: <Widget>[
          Container(
          width: double.infinity,
            height:  250.0,
            color: Colors.yellow,
            child: Image.asset(
            'Images/waves.png',
            fit: BoxFit.fill,
          ),
            ),
         ] ),
   ]));
  }
}
