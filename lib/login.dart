import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myresult/gridmenu.dart';
import 'package:myresult/home.dart';
import 'package:myresult/result.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


String matrik = '';
String nama ='';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nomatrix = new TextEditingController();
  TextEditingController password = new TextEditingController();
  final _formKey = GlobalKey<FormState>();


  final focus = FocusNode();

  var connectionstatus = 'Unknown';
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState(){
    super.initState();
    connectivity = new Connectivity();
    subscription = connectivity.onConnectivityChanged.listen((ConnectivityResult result){
      if(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi){
        Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
      }else{
        Alert(
          context: context,
          title: "Oops!",
          desc: "Looks Like Your Connection Lost,  Please Toggle the Mobile Data or Wifi",
          image: Image.asset('images/dead.png', width: 40.0, height: 40.0, color: Color.fromRGBO(73, 48, 123, 2),),
          style: AlertStyle(
              isCloseButton: false,
              isOverlayTapDismiss: false,
              titleStyle: TextStyle(fontFamily: 'raleway', fontWeight: FontWeight.bold),
              descStyle: TextStyle(fontFamily: 'raleway', fontSize: 15.0),
              alertBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))
          ),
          buttons: [
            DialogButton(
              radius: BorderRadius.circular(20.0),
              child: Text(
                "Got It",
                style: TextStyle(color: Colors.white, fontSize: 17 ,fontFamily: 'raleway', fontWeight: FontWeight.bold),
              ),
              onPressed: () => Navigator.pop(context),
              color: Color.fromRGBO(73, 48, 123, 2),
            ),
          ],
        ).show();
      }
    });
  }


  @override
  /*void dispose(){
    subscription.cancel();
    super.dispose();
  }*/

  Future<void> _login() async {
    final response = await http.post("http://api.umt.edu.my/student/login",
        body: {
          "matrik" : nomatrix.text,
          "password" : password.text
        }
    );

    if(response.statusCode == 200){
      var user = json.decode(response.body);

      if(user['status'] == true){

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('matrik', nomatrix.text);
        prefs.setString('password', password.text);

        Alert(
            context: context,
            title: "Redirecting...",
            desc: "Teroka Seluas Lautan",
            content: Padding(padding: EdgeInsets.only(top:20.0),child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueAccent)
            ),),
            style: AlertStyle(
                isCloseButton: false,
                isOverlayTapDismiss: false,
                titleStyle: TextStyle(fontFamily: 'raleway', fontWeight: FontWeight.bold),
                descStyle: TextStyle(fontFamily: 'raleway', fontSize: 15.0),
                alertBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))
            ),
            buttons: []
        ).show();

        Future.delayed(Duration(seconds: 3),(){
          Navigator.pop(context);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ExampleGrid()));
        });

        setState(() {
          matrik = nomatrix.text;
          nama = user['data'];
          print(nama);

        });

      }else {

        Alert(
          context: context,
          title: "Oops!",
          //image: Image.asset('images/dead.png', width: 40.0, height: 40.0, color: Color.fromRGBO(73, 48, 123, 2),),
          desc: "You Might Enter Wrong Matrix No or Password",
          style: AlertStyle(
              isCloseButton: false,
              isOverlayTapDismiss: false,
              titleStyle: TextStyle(fontFamily: 'raleway', fontWeight: FontWeight.bold),
              descStyle: TextStyle(fontFamily: 'raleway', fontSize: 15.0),
              alertBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))
          ),
          buttons: [
            DialogButton(
              radius: BorderRadius.circular(20.0),
              child: Text(
                "Try Again? ",
                style: TextStyle(color: Colors.white, fontSize: 17 ,fontFamily: 'raleway', fontWeight: FontWeight.bold),
              ),
              onPressed: () => Navigator.pop(context),
              color: Colors.blueAccent
            ),
          ],
        ).show();

      }

      return CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Color.fromRGBO(73, 48, 123, 2)));

    }else{
      Alert(
        context: context,
        title: "Oops!",
        desc: "Looks Like Lost Connection to the Server",
        //image: Image.asset('images/dead.png', width: 40.0, height: 40.0, color: Color.fromRGBO(73, 48, 123, 2),),
        style: AlertStyle(
            isCloseButton: false,
            isOverlayTapDismiss: false,
            titleStyle: TextStyle(fontFamily: 'raleway', fontWeight: FontWeight.bold),
            descStyle: TextStyle(fontFamily: 'raleway', fontSize: 15.0),
            alertBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))
        ),
        buttons: [
          DialogButton(
            radius: BorderRadius.circular(20.0),
            child: Text(
              "Got It",
              style: TextStyle(color: Colors.white, fontSize: 17 ,fontFamily: 'raleway', fontWeight: FontWeight.bold),
            ),
            onPressed: () => Navigator.pop(context),
            color: Colors.blueAccent,
          ),
        ],
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,

      body:
      LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Stack(
                  children: <Widget>[
                    Column(
                      key: _formKey,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          color: Colors.white,
                          height: 350.0,
                          width: double.infinity,
                          child: Image.asset(
                            'Images/waves.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                        Expanded(child: Container()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: TextFormField(
                            controller: nomatrix,
                            validator: (value) => value.isEmpty ?'Masukkan no matrik' :null,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person,color: Colors.blueAccent,),
                              prefixStyle: TextStyle(
                                color: Colors.red,
                              ),
                              hintText: 'No Matrik',
                              hintStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: TextField(
                            controller: password,
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon: Image.asset(
                                  'Images/icon-password.png'),
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                                Container(
                                child: RaisedButton(
                                  onPressed: () => {
                                    _login(),
                                  },
                                  textColor: Colors.white,
                                  padding: const EdgeInsets.all(0.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                                  child: Container(
                                    width: 200,
                                    decoration: new BoxDecoration(
                                        gradient: new LinearGradient(
                                          colors: [
                                            Color(0xFF0D47A1),
                                            Color(0xFF1976D2),
                                            Color(0xFF42A5F5),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(30.0)
                                    ),
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                    "Login",
                                    textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),

                           /* Padding(
                              padding: EdgeInsets.symmetric(horizontal: 32),

                              child: RaisedButton(
                               // color: Color.fromRGBO(52, 137, 246, 1),
                                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                                onPressed: () => {
                                  _login(),
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: <Color>[
                                        Color(0xFF0D47A1),
                                        Color(0xFF1976D2),
                                        Color(0xFF42A5F5),
                                      ],
                                    ),),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),)*/
                          ],

                        ),


                        SizedBox(height: 20),
                        /*CupertinoButton(
                          onPressed: () => {},
                          child: Text(
                            'FORGOT PASSWORD?',
                            style: TextStyle(
                              color: Color.fromRGBO(52, 137, 246, 1),
                              fontFamily: 'Montserrat',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),*/
                        Expanded(child: Container()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Pusat Pengurusan Pengetahuan Teknologi & Komunikasi, UMT',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 7,
                                fontWeight: FontWeight.w400,
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                    Positioned(
                      left: 0,
                      top: 128,
                      right: 0,
                      child: Container(
                        width: 100,
                        height: 100,
                        child:Image.asset(
                          'Images/myresult.png',
                          fit: BoxFit.contain,
                        ),


                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      /*SizedBox.expand( //nk bg penuh
        child: Container(

          // padding: EdgeInsets.only(top: 10.0),
          decoration: new BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue,Colors.greenAccent],
            ),

          ),
          //child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 50) ,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('My3K',style: TextStyle(
                  fontSize: 40.0,
                  //letterSpacing: 2.0,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
                ),
                Text('Kembali Ke Kampus',style: TextStyle(
                  fontSize: 30.0,
                  letterSpacing: 2.0,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
                ),
                Container(
                  //width: 20.0,
                  child: Image.asset('assets/images/logo.png', scale: 4),// tukar gambar

                ),
                Container(

                  child:  Stack(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(

                              child: Column(
                                children: <Widget>[

                                  Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                  ),

                                  Container(
                                    width: 200.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      color: Colors.white70,
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color: Colors.black45,
                                      ),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 10.0,
                                            offset: Offset(0.0, 0.0)
                                        ),
                                      ],
                                    ),
                                    child: TextField(
                                      controller: nomatrix,
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.credit_card),
                                          hintText: 'No Kp',
                                          contentPadding: EdgeInsets.only(left: 5.0, top: 12.5),
                                          border: InputBorder.none
                                      ),
                                      onSubmitted: (v){
                                        FocusScope.of(context).requestFocus(focus);
                                      },
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                  ),

                                  /* Container(
                                    width: 200.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      color: Colors.white70,
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color: Colors.black45,
                                      ),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 10.0,
                                            offset: Offset(0.0, 0.0)
                                        ),
                                      ],
                                    ),
                                    child: TextField(
                                      cursorColor: Colors.brown,
                                      controller: password,
                                      obscureText: true,
                                      decoration: InputDecoration(

                                        prefixIcon: Icon(Icons.lock),
                                        hintText: 'password',
                                        contentPadding: EdgeInsets.only(left: 5.0, top: 12.5),
                                        border: InputBorder.none,
                                      ),
                                      focusNode: focus,
                                      onSubmitted: (v){
                                        _login();
                                      },
                                    ),// test

                                  )*/
                                ],)
                          )
                        ],
                      ),

                    ],
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),), //90
                      Center(
                        child: RaisedButton(
                          shape: StadiumBorder(),
                          color: Colors.deepOrangeAccent,
                          textColor: Colors.white,
                          child: Text(" MASUK",style: TextStyle( decoration: TextDecoration.none)),
                          padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 30.0),
                          elevation: 0.0,
                          onPressed: (){
                            _login();
                          },


                        ),
                      ),
                      SizedBox(width: 10),

                      Center(

                        child: RaisedButton(
                          shape: StadiumBorder(),
                          color: Colors.deepOrangeAccent,
                          textColor: Colors.white,
                          child: Text("CANCEL",style: TextStyle(fontSize: 14.0),),
                          padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 30.0),
                          elevation: 0.0,
                          //onPressed: ()=> exit(0),
                          onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context)=>Daftar()));},

                        ),
                      ),
                    ]
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Image( image: AssetImage('assets/images/covid192.png'))
                    //new image: new DecorationImage(
                    // image: AssetImage('assets/images/covid192.png'),
                    //fit: BoxFit.fill,
                    // ),
                    // ),
                    //your elements here
                  ],
                ),


              ],
            ),
          ),

        ),
      ),*/
    );
  }
}