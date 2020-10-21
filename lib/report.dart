import 'package:flutter/material.dart';
import 'package:myresult/login.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:myresult/result.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

class bantuan extends StatefulWidget {
  
  @override
  _bantuanState createState() => _bantuanState();
}

class _bantuanState extends State<bantuan> {
  String nomatrik;
  Future<void> checkUserStatus() async {


    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nomatrik = prefs.getString('sessmatrik');

    });

  }
  @override
  void initState() {
    super.initState();
    checkUserStatus();
  }


  int _currentIndex = 0;
  final   _pageOptions = [PelResult(matrik), bantuan(),];
    //@override

  onTabTapped(int index) {
    setState(() {

      _currentIndex = index;
      print(_currentIndex);
    });

    /*if (index == 0) {
      //return PageOne(data:data);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => PelResult(nomatrik)));
    }

    if (index == 1) {
      //return PageOne(data:data);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => bantuan()));
    }*/
  }
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: new Center(child: Text("INFO")),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.purple[400],
                  Colors.yellow[800]
                ]
            ),
          ),
        ),
       
      ),*/
      //title: Text("Info"),
      //actions: <Widget>[ new Image.asset('images/logoumt.png') ,],

      body:
      Container(

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
                        height: 350.0,//350.0,
                        width: double.infinity,
                        child: Image.asset(
                        'Images/waves.png',
                        fit: BoxFit.fill,
                        ),
                        ),
                        SizedBox(height: 5,),
                        ],
                        ),

                Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 50,),
                      Center(
                        child: Container(
                          
                          color: Colors.transparent,
                        child:Text('TALIAN BANTUAN AKADEMIK', style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white
                          ,
                        ),),

                      ),),

                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.all(10),
                          children: <Widget>[
                        Divider(height: 0.0,),
                            Card(
                              shadowColor: Colors.grey,
                              //color:Color.fromRGBO(240, 240, 255, 1),
                                color: Color.fromRGBO(240, 216, 216, 1),
                              child: InkWell(
                                splashColor: Colors.blue.withAlpha(30),
                                onTap: (){launch("tel: 09 - 668 4219 ");},
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: Text('Jabatan Pengurusan Akademik (JPA) UMT'),
                                      subtitle:Text('09 - 668 4219', style: TextStyle(color: Color.fromRGBO(24, 96, 168, 1)), ),
                                      trailing: Icon(Icons.phone, color: Color.fromRGBO(24, 48, 96,10),),
                                    ),
                                  ],
                                ),
                              ),

                            ),
                            Card(
                              shadowColor: Colors.grey,
                              color:Color.fromRGBO(240, 240, 255, 1),
                              child: InkWell(
                                splashColor: Colors.blue.withAlpha(30),
                                onTap: (){launch("tel: 09 - 668 4431 ",);},
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        title: Text('Fakulti Perniagaan, Ekonomi & Pembangunan Sosial'),
                                        subtitle:Text('09 - 668 4431',style: TextStyle(color: Color.fromRGBO(24, 96, 168, 1)), ),
                                        trailing: Icon(Icons.phone, color: Color.fromRGBO(24, 48, 96,10),),
                                      ),

                                ],
                              ),
                            ),),
                            Card(
                                shadowColor: Colors.grey,
                                color: Color.fromRGBO(240, 216, 216, 1),
                              child: InkWell(
                                splashColor: Colors.blue.withAlpha(30),
                                onTap: (){launch("tel: 09 - 668 3791 ", );},
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Text('Fakulti Pengajian Maritim'),
                                    subtitle: Text('09 - 668 3791',style: TextStyle(color: Color.fromRGBO(24, 96, 168, 1)),),
                                    trailing: Icon(Icons.phone, color: Color.fromRGBO(24, 48, 96,10),),
                                  ),

                                ],
                              ),)
                            ),
                            Card(
                              shadowColor: Colors.grey,
                              color:Color.fromRGBO(240, 240, 255, 1),
                              child: InkWell(
                                splashColor: Colors.blue.withAlpha(30),
                                  onTap: (){launch("tel: 09 - 668 4931 ");},
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: Text('Fakulti Perikanan Dan Sains Makanan'),
                                      subtitle: Text('09 - 668 4931',style: TextStyle(color: Color.fromRGBO(24, 96, 168, 1)), ),
                                      trailing: Icon(Icons.phone, color: Color.fromRGBO(24, 48, 96,10),),
                                    ),
                                ],
                              ),
                            ),),
                            Card(
                              shadowColor: Colors.grey,
                                color: Color.fromRGBO(240, 216, 216, 1),
                              child: InkWell(
                                splashColor: Colors.blue.withAlpha(30),
                                onTap: (){launch("tel: 09 - 668 3990 ");},
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: Text('Fakulti Sains Dan Sekitaran Marin'),
                                      subtitle:  Text('09 - 668 3990',style: TextStyle(color: Color.fromRGBO(24, 96, 168, 1)), ),
                                      trailing: Icon(Icons.phone, color: Color.fromRGBO(24, 48, 96,10),),
                                    ),

                                ],
                              ),
                              )),
                            Card(
                              shadowColor: Colors.grey,
                                color:Color.fromRGBO(240, 240, 255, 1),
                              child: InkWell(
                                splashColor: Colors.blue.withAlpha(30),
                                onTap: (){launch("tel: 09 - 668 3287 ");},
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: Text('Fakulti Teknologi Kejuruteraan Kelautan & Informatik'),
                                      subtitle: Text('09 - 668 3287',style: TextStyle(color: Color.fromRGBO(24, 96, 168, 1)), ),
                                      trailing: Icon(Icons.phone, color: Color.fromRGBO(24, 48, 96,10),),
                                    ),

                                  ],
                                ),
                            )),
                            Card(
                              shadowColor: Colors.grey,
                                color: Color.fromRGBO(240, 216, 216, 1),
                              child: InkWell(
                                splashColor: Colors.blue.withAlpha(30),
                                  onTap: (){launch("tel:09 - 668 3753 ");},
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        title: Text('Pusat Asasi Stem'),
                                        subtitle:  Text('09 - 668 3753',style: TextStyle(color: Color.fromRGBO(24, 96, 168, 1)),),
                                        trailing: Icon(Icons.phone, color: Color.fromRGBO(24, 48, 96,10),),
                                      ),

                                ],
                              ),
                            )),
                            Card(
                              shadowColor: Colors.grey,
                                color:Color.fromRGBO(240, 240, 255, 1),
                              child: InkWell(
                                splashColor: Colors.blue.withAlpha(30),
                                onTap: (){launch("tel: 09 - 668 4111 ");},
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                          title: Text('Pejabat Bendahari'),
                                          subtitle: Text('09 - 668 4111',style: TextStyle(color: Color.fromRGBO(24, 96, 168, 1)), ),
                                          trailing: Icon(Icons.phone, color: Color.fromRGBO(24, 48, 96,10),)
                                      ),

                                    ],
                                  ),
                            )),

                          ],)),

                    ],

                ),

                ]),


    ));


  }
}
