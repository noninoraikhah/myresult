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




class PelProfile extends StatefulWidget {
  final String matrik;
  PelProfile(this.matrik);



  @override
  _PelProfileState createState() => _PelProfileState(matrik);
}

class _PelProfileState extends State<PelProfile>{
  String matrik;
  String nama;
  _PelProfileState(this.matrik);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:
        Container(
        //color: Colors.black,
          child: Stack(
          children: <Widget>[
            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            // mainAxisSize: MainAxisSize.max,
            children: <Widget>[

              Container(
              //color: Colors.white,
              height: 250.0,//350.0,
              width: double.infinity,
                //child: Image.asset('https://mynemo.umt.edu.my/foto.php?800101116340',
                child: Image.asset(
              'Images/waves.png',
            fit: BoxFit.fill,
              ),
              ),
              SizedBox(height: 5,),
    ],
    ),
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
                alignment: Alignment.center,
                padding: EdgeInsets.all(28.0),
                child:Column(
                  //crossAxisAlignment:CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child:
                      Container(
                        //color: Colors.red,
                        width: double.infinity,
                        height:150,
                        child: Column(
                          children: <Widget>[

                            CircleAvatar(backgroundImage: NetworkImage('https://mynemo.umt.edu.my/images/cekk.gif'), radius: 50.0, backgroundColor: Colors.transparent,),
                            SizedBox(height: 5),
                            Flexible( child:Text('$nama', style: TextStyle(
                                fontFamily: 'raleway',
                                color: Colors.white,fontSize: 18), softWrap: true, textAlign: TextAlign.center ),),

                            Flexible( child:Text('$program', style: TextStyle(
                                fontFamily: 'raleway',
                                color: Colors.white, fontSize: 9),softWrap: true, textAlign: TextAlign.center ),),

                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                         ListTile(
                            leading: CircleAvatar( radius: 20,backgroundColor: Colors.grey, child: CircleAvatar( child: Icon(Icons.home, size: 20, color: Colors.lightBlue),
                                radius: 18,backgroundColor: Colors.white ),),
                            //Icon(Icons.phone, size: 20, color: Colors.green),
                            title: Text('Alamat', style: TextStyle(color: Colors.black54, fontSize: 12)),
                            subtitle: Text('$alamattetap1' + ', $alamattetap2' + ', $negeritetap', style: TextStyle(color: Colors.black, fontSize: 15)),

                          ),
                          ListTile(
                            leading: CircleAvatar( radius: 20,backgroundColor: Colors.grey, child: CircleAvatar( child: Icon(Icons.phone, size: 20, color: Colors.green),
                                radius: 18 ,backgroundColor: Colors.white ),),
                            title: Text('Telefon', style: TextStyle(color: Colors.black54, fontSize: 12)),
                            subtitle: Text('$notel', style: TextStyle(color: Colors.black, fontSize: 15)),

                          ),
                          ListTile(
                            leading: CircleAvatar( radius: 20,backgroundColor: Colors.grey, child: CircleAvatar( child: Icon(Icons.supervisor_account, size: 20, color: Colors.yellow),
                                radius: 19 ,backgroundColor: Colors.white ),),
                            title: Text('Pembimbing', style: TextStyle(color: Colors.black54, fontSize: 12)),
                            subtitle: Text('$mentor', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)),

                          ),

                          ListTile(
                            leading: CircleAvatar( radius: 20,backgroundColor: Colors.grey, child: CircleAvatar( child: Icon(Icons.perm_phone_msg, size: 20, color: Colors.pinkAccent),
                                radius: 18 ,backgroundColor: Colors.white ),),
                            title: Text('Tel Pembimbing', style: TextStyle(color: Colors.black54, fontSize: 12)),
                            subtitle: Text('$notelmentor', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold,)),

                          ),


                        ],
                      ),




                  ],
                ),);






                  } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");}

                  return CircularProgressIndicator();

                }
            ),

            )]
          ),
        ));

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
  String token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9hcGkudW10LmVkeS5teVwvZnVzaW9cL3B1YmxpYyIsInN1YiI6IjBiYTBjYTU3LTRjY2MtNTMwMi05NzdjLWMxZmNmNGNmMWVjNiIsImlhdCI6MTU5ODE1NTM3OCwiZXhwIjo0NzIyMjA2NTc4LCJuYW1lIjoiYnBhX21vYmlsZSJ9.moUazkrbuByTbAkc6UJMsIXDWM0AvP0jbJtoftPWvlk';
  final response =
  await http.get('http://api.umt.edu.my/student/student_profile/$matrik', headers: {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'Authorization': 'Bearer $token',});

  if (response.statusCode == 200) {
    token= response.body;

    return Getdata.fromJson(json.decode(response.body));
  } else {

    throw Exception('Failed to load post');
  }

}

