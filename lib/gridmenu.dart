import 'package:flutter/material.dart';
import 'package:myresult/login.dart';
import 'package:myresult/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ButtonType { myResult, donate, receiptients, offers }

class ExampleGrid extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:SafeArea(
          child: Container(
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
                      child: Image.asset(
                    'Images/waves.png',
                    fit: BoxFit.fill,
                ),
                ),
                SizedBox(height: 5,),
                ],
                ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(height: 20),
                              Image.asset('Images/logo.png', scale: 5) ,
                              SizedBox(height: 20),
                              Text('Selamat Datang ', style:  TextStyle(color: Colors.white, fontSize: 20)),
                              Text('$nama', style:  TextStyle(color: Colors.white, fontSize: 20)),
                            ],
                          )

                        ],

                      ),
                    SizedBox(height: 80),
                    Container(
                      child: Card(
                        child: Column(
                          children: [
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Flexible(
                                  child: CustomButton(buttonType: ButtonType.myResult,),
                                ),
                                Flexible(
                                  child: CustomButton(buttonType: ButtonType.donate),
                                ),
                                Flexible(
                                  child:
                                  CustomButton(buttonType: ButtonType.receiptients, ),
                                ),
                                Flexible(
                                  child: CustomButton(buttonType: ButtonType.offers),
                                ),
                              ],
                            ),

                          ],
                        )

                      ),
                      padding: EdgeInsets.all(21),
                      //color: Color(0xfff4f5f9),

                    ),
                ],
                ),
          ]),
          ),
    ),

    );
  }
}
class CustomButton extends StatelessWidget {
  final ButtonType buttonType;
  const CustomButton({Key key, this.buttonType}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String buttonText = "", buttonImage, routesX;
    var dataPass;


    switch (buttonType) {
      case ButtonType.myResult:
        buttonText = "Myresult";
        buttonImage = "Images/hiclipart.png";
        routesX = "/buttonpay";
        dataPass={'param':"$matrik"};
        break;
      case ButtonType.donate:
        buttonText = "Bantuan";
        buttonImage = "Images/help.png";

        break;
      case ButtonType.receiptients:
        buttonText = "QR Kehadiran";
        buttonImage = "Images/qrcode.png";
        break;
      case ButtonType.offers:
        buttonText = "CGPA";
        buttonImage = "Images/cgpa.png";

        break;
    }
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(routesX,arguments: dataPass);
          print(dataPass);
          // camne nak save route dalam case

        },
        child: Container(
          padding: EdgeInsets.all(3.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  ),
                child: Image.asset(
                  buttonImage,
                ),
              ),
              SizedBox(
                height: 1.0,
              ),
              FittedBox(
                child: Text(buttonText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}