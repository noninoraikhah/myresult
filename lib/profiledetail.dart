import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:myresult/login.dart';

class DetailProfile extends StatefulWidget {
  final String matrik;
  DetailProfile(this.matrik);

  @override
  _DetailProfileState createState() => _DetailProfileState(matrik);
}

class _DetailProfileState extends State<DetailProfile> {
  String matrik;
  String nama;
  _DetailProfileState(this.matrik);

  @override
  Widget build(BuildContext context) {
    Container(
      child:FutureBuilder<Getdata>(
          future: fetchGetdata(),
          builder: (context, snapshot){
            if (snapshot.hasData) {
              String nama =snapshot.data.nama;
              //String matrik =snapshot.data.matrik;
              String program =snapshot.data.program;
              String alamattetap1 =snapshot.data.alamattetap1;
              String alamattetap2 =snapshot.data.alamattetap2;
              String negeritetap =snapshot.data.negeritetap;
              String alamatsurat1=snapshot.data.alamatsurat1;
              String alamatsurat2=snapshot.data.alamatsurat2;
              String negerisurat=snapshot.data.negerisurat;
              String mentor =snapshot.data.mentor;
              String notel =snapshot.data.notel;
              String cgpa =snapshot.data.cgpa;
              String notelmentor= snapshot.data.notelmentor;
              String emailmentor= snapshot.data.emailmentor;
              String png =snapshot.data.png;



              return Container(
                padding: EdgeInsets.all(15.0),
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                Expanded(
                child: ListView(
                  children: <Widget>[
                  ListTile(
                  leading: Icon(Icons.book, color: Colors.deepPurple,),
                title:
                Text('Program:', style: TextStyle(
                    fontFamily: 'raleway',
                    fontWeight: FontWeight.bold) ),

                subtitle: Text('program' ),

              ),
            ListTile(
            leading: Icon(Icons.phone, color: Colors.blueAccent,),
            title:
            Text(' Telefon', style: TextStyle(
            fontWeight: FontWeight.bold) ),

            subtitle: Text('notel'),
            ),
            ],),

            ),




                  ],

                ),



              );


            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");}

            return CircularProgressIndicator();

          }
      ),
    );
  }
}


class Getdata{
//final String matrik;
  final String nama;
  final String program;
  final String alamattetap1;
  final String alamattetap2;
  final String negeritetap;
  final String mentor;
  final String notel;
  final String alamatsurat1;
  final String alamatsurat2;
  final String negerisurat;
  final String notelmentor;
  final String emailmentor;
  final String email;
  final String image;
  final String cgpa;
  final String png;


  Getdata({//this.matrik,
    this.nama, this.program, this.alamattetap1, this.alamattetap2,
    this.negeritetap, this.alamatsurat1, this.alamatsurat2, this.negerisurat,
    this.mentor, this.notelmentor, this.emailmentor, this.notel, this.email, this.image,this.cgpa, this.png,
  });

  factory Getdata.fromJson(Map<String,dynamic> json){
    return Getdata(
      //matrik: json['data']['MATRIK'],
      nama:json['data']['NAMA'],
      program: json['data']['PROGRAM'],
      alamattetap1: json['data']['ALAMATTETAP1'],
      alamattetap2: json['data']['ALAMATTETAP2'],
      negeritetap: json['data']['NEGERITETAP'],
      alamatsurat1: json['data']['ALAMATSURAT1'],
      alamatsurat2: json['data']['ALAMATSURAT2'],
      negerisurat: json['data']['NEGERISURAT'],
      mentor: json['data']['MENTOR'],
      notelmentor: json['data']['NOTEL_MENTOR'],
      emailmentor: json['data']['EMAIL_MENTOR'],
      notel: json['data']['NOTEL'],
      email: json['data']['EMAIL'],
      image: json['data']['EMAIL'],
      cgpa: json['data1']['CGPA'],
      png: json['data1']['PNG'],
      //gred: json['kursus']['GRED'],
    );
  }

}


Future<Getdata> fetchGetdata() async {
  final response =
  await http.get('http://api.umt.edu.my/student/student_profile/$matrik');

  if (response.statusCode == 200) {

    return Getdata.fromJson(json.decode(response.body));
  } else {

    throw Exception('Failed to load post');
  }

}
