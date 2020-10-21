import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myresult/login.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:myresult/result.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:myresult/report.dart';
import 'package:myresult/profile.dart';
//import 'signout.dart';


class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  int _currentIndex = 0;
  
  
  final   _pageOptions = [PelResult(matrik), bantuan(), PelProfile(matrik), ];
  //@override

  onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      print(_currentIndex);
    });
    print(matrik);


  }
  Future logOutUser(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacementNamed(context, '/login');
  }

   _signOut() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs?.clear();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (BuildContext context) => LoginPage()),(Route route) => false);

  }
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    return Scaffold(


      body: Container(
        child:_pageOptions[_currentIndex],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          AlertDialog alertDialog=AlertDialog(
            title: Text( 'Keluar'),
            content: Text( 'Adakah anda pasti ingin keluar?'),
            actions: <Widget>[
              FlatButton(
                child: Text('Ya'),
                onPressed: (){
                  _signOut();
                },
              ),
              FlatButton(
                child: Text('Tidak'),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              )
            ],
          );
          showDialog(context: context, barrierDismissible: false, builder: (BuildContext context){return alertDialog;});
        },
        label: Text('Keluar'),
        //icon: Icon(Icons.thumb_up),

        backgroundColor: Colors.pink,


      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,


      bottomNavigationBar:
      FancyBottomNavigation(
        circleColor: Color.fromRGBO(24, 96, 168, 1),
        textColor: Color.fromRGBO(24, 96, 168, 1),
        inactiveIconColor: Colors.blueGrey,

        //barBackgroundColor: Color.fromRGBO(240, 216, 216, 1),

        tabs: [
          TabData(iconData: Icons.school, title:'MyResult'),
          //icon: ImageIcon(AssetImage('Images/score.png')), title: Text('MyResult')),
          TabData(iconData: Icons.phone_forwarded, title:'Bantuan'),
          TabData(iconData: Icons.person, title:'Profile'),
          TabData(iconData: Icons.arrow_forward, title:'Keluar', onclick:(){_signOut();} ),

        ],


        onTabChangedListener: onTabTapped,
      ),
         );

  }
}
