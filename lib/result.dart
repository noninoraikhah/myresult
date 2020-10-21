import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myresult/report.dart';
import 'login.dart';
import 'package:flutter/cupertino.dart';
import 'package:myresult/report.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PelResult extends StatefulWidget {
  final String nomatrik;
  PelResult(this.nomatrik);

  @override
  _PelResultState createState() => _PelResultState(nomatrik);


}

class _PelResultState extends State<PelResult > {
  String nomatrik;
  _PelResultState(this.nomatrik);



  Future<List<User>> _getUsers() async {

    var data = await http.get(
        //'http://api.umt.edu.my/student/student_result/S42812');
        'http://api.umt.edu.my/student/student_result/$nomatrik');
    print('print $nomatrik');

    var jsonData = json.decode(data.body);

    List<User> users = [];

    for(var u in jsonData){

      User user = User(u['SESI'], u['KODKURSUS'],
          u['KURSUS'], u['GRED']);

      users.add(user);

    }

    print(users.length);

    return users;

  }

  /*_getUsers() {
    API.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        users = list.map((model) => User.fromJson(model)).toList();
      });
    });
  }*/

  initState() {
    super.initState();
    //_getUsers();
  }

  dispose() {
    super.dispose();
  }

  Widget _buildexpansion(){
    return FutureBuilder(
        future: _getUsers(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.data ==null){
            return Container(
              child: Center( child: Text("Loading....")),
            );
          }

          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index){
                return Card(
                  color: Color.fromRGBO(240, 240, 255, 1),
                  //color: Color.fromRGBO(240, 216, 216, 1),
                  child: ListTile(
                      title: Text(snapshot.data[index].kodkursus, style: TextStyle(color: Color.fromRGBO(24, 48, 96, 10),)),
                      subtitle: Text(snapshot.data[index].kursus, style: TextStyle(color: Color.fromRGBO(24, 48, 96, 10),)),
                      trailing: Text(snapshot.data[index].gred, style: TextStyle(color: snapshot.data[index].gred=='F' ? Colors.red : Colors.blue, fontWeight: FontWeight.bold, fontSize: 20) )
                  ),);


              }
          );

        }
    );

  }


  @override
  build(context)  {
    return Scaffold(
      body: Container(
        color: Colors.white,
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    height: 330.0,//350.0,
                    width: double.infinity,
                    child: Image.asset(
                      'Images/waves.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                SizedBox(height: 5,),
              ],
            ),

            Container (

              child:FutureBuilder<Getdata>(
                  future: fetchGetdata(),
                  builder: (context, snapshot){
                    if (snapshot.hasData) {
                      String nama =snapshot.data.nama;
                      String namaprogram=snapshot.data.namaprogram;
                      String cgpa=snapshot.data.cgpa;
                      String png=snapshot.data.png;
                      String sesi=snapshot.data.sesi;

                      return Container(
                        //color: Colors.white,
                        //height: 300,
                        //width: 500,
                        margin: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[

                            SizedBox(height: 20,),
                            Image.asset(
                              'Images/logo.png',
                              scale: 5,
                              //fit: BoxFit.fill,
                            ),
                            SizedBox(height: 10,),
                            Text('$nama', style: TextStyle(
                                color: Colors.white)),
                            ListTile(
                              subtitle: Text('(CGPA)', style: TextStyle(
                                  color: Colors.white) ),
                              trailing: Text('$cgpa', style: TextStyle(
                                  color: Colors.white, fontSize: 18)),
                              title: Text('Keputusan Semester',style: TextStyle(
                                  color: Colors.white)),
                            ),
                            new ListTile(
                              subtitle: Text('(PNG)',style: TextStyle(
                                  color: Colors.white) ),
                              trailing: Text('$png', style: TextStyle(
                                  color: Colors.white, fontSize: 18) ),
                              title: Text('Purata Tahunan', style: TextStyle(
                                  color: Colors.white)),
                            ),
                            SizedBox(height: 20,),
                            Text('KEPUTUSAN SEMESTER TERKINI: $sesi', style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold, )),
                            /*Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [Colors.blue, Colors.greenAccent])),
                               child: Text('SESI: $sesi', style: TextStyle(fontSize: 20.0)),
                            ),*/


                            Expanded(

                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFF0E3311).withOpacity(0.0)
                                  ),
                                  padding: EdgeInsets.only(bottom: 20),

                                  child: _buildexpansion(),
                            )),


                          ],

                        ),

                      );



                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");}

                    return Center(child: CircularProgressIndicator());

                  }
              ),

            ),


          ])),

    );


  }
}


class Getdata{
//final String matrik;
  final String nama;
  final String namaprogram;
  final String cgpa;
  final String png;
  final String sesi;
//final String kod;
//final String gred;

  Getdata({//this.matrik, 
    this.nama, this.namaprogram, this.cgpa, this.png, this.sesi
    //this.kod, 
    //this.gred 
  });

  factory Getdata.fromJson(Map<String,dynamic> json){
    return Getdata(
      //matrik: json['MATRIK'],
      nama:json['NAMA'],
      namaprogram: json['PROGRAM'],
      cgpa: json['CGPA'],
      png: json['PNG'],
      sesi: json['SESI'],
      //kod: json['kursus']['KOD_KURSUS'],
      //gred: json['kursus']['GRED'],
    );
  }

}
Future<Getdata> fetchGetdata() async {
  final response =
  await http.get('http://api.umt.edu.my/student/resultcurrent/$matrik');
  print (matrik);

  if (response.statusCode == 200) {

    return Getdata.fromJson(json.decode(response.body));
  } else {
    //var context;
    //Alert(context: context, title: "RFLUTTER", desc: "Flutter is awesome.").show();

    throw Exception('Failed to load post');
  }

}

const baseUrl = "http://api.umt.edu.my/student/student_result/";

class API {
  static Future getUsers() {
    var url = baseUrl  + '/$matrik' ;
    return http.get(url);

  }
}

class User {
  String sesi;
  String kodkursus;
  String kursus;
  String gred;

  User(String sesi, String kodkursus, String kursus, String gred) {
    this.sesi = sesi;
    this.kodkursus= kodkursus;
    this.kursus = kursus;
    this.gred = gred;
  }
}
