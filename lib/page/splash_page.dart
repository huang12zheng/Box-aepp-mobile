import 'dart:ui';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:box/generated/l10n.dart';
import 'package:box/page/home_page.dart';
import 'package:box/page/login_page.dart';
import 'package:box/widget/custom_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String _value = "";

  @override
  void initState() {
    super.initState();
    BoxApp.showOverlay(context);
    BoxApp.getLanguage().then((String value) {
//      print("getLanguage->" + value);
//      S.load(Locale(value, value.toUpperCase()));
//      setState(() {
//        _value = value;
//      });
//      Future.delayed(Duration(seconds: 1), () {
//        S.load(Locale(value, value.toUpperCase()));
////        Navigator.pushReplacement(context,LoginPage());
//        goHome();
//      });
    });

    SharedPreferences.getInstance().then((sp) {
      var isLanguage = sp.getString('is_language');
      if (isLanguage == "true") {
        BoxApp.getLanguage().then((String value) {
          print("getLanguage->" + value);
          S.load(Locale(value, value.toUpperCase()));
          setState(() {
            _value = value;
          });
          Future.delayed(Duration(seconds: 1), () {
            S.load(Locale(value, value.toUpperCase()));
            goHome();
          });
        });
      }else{
        Future.delayed(Duration.zero, () {
          showPlatformDialog(
            context: context,
            builder: (_) => BasicDialogAlert(
              title: Text(
                "选择语言 / Language",
              ),
              content: Text(
                "Please choose the language you want to use\n请选择你要使用的语言",
              ),
              actions: <Widget>[
                BasicDialogAction(
                  title: Text(
                    "中文",
                    style: TextStyle(
                      color: Color(0xFFFC2365),
                      fontFamily: "Ubuntu",
                    ),
                  ),
                  onPressed: () {
                    BoxApp.setLanguage("cn");
                    //通知将第一页背景色变成红色
                    S.load(Locale("cn", "cn".toUpperCase()));
                    Navigator.of(context, rootNavigator: true).pop();

                    goHome();
                  },
                ),
                BasicDialogAction(
                  title: Text(
                    "English",
                    style: TextStyle(
                      color: Color(0xFFFC2365),
                      fontFamily: "Ubuntu",
                    ),
                  ),
                  onPressed: () {
                    BoxApp.setLanguage("en");
                    //通知将第一页背景色变成红色
                    S.load(Locale("en", "en".toUpperCase()));
                    Navigator.of(context, rootNavigator: true).pop();
                    goHome();
                  },
                ),
              ],
            ),
          );
        });
      }
    });


  }

  void goHome() {
    BoxApp.getAddress().then((value) {
      SharedPreferences.getInstance().then((sp) {
        sp.setString('is_language', "true");
        if (value.length > 10) {
          Navigator.pushReplacement(context, CustomRoute(HomePage()));
        } else {
          Navigator.pushReplacement(context, CustomRoute(LoginPage()));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Color(0xFFFFFFFFF),
        body: Container(
          child: Stack(
            alignment: Alignment.center,
            children: [

              Positioned(
                bottom: MediaQueryData.fromWindow(window).padding.bottom + 50,
                child: Container(
                  alignment: Alignment.center,
                  child: Image(
                    width: 153,
                    height: 36,
                    image: AssetImage('images/home_logo_left.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
