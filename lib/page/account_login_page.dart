import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:box/page/mnemonic_confirm_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AccountLoginPage extends StatefulWidget {
  @override
  _AccountLoginPageState createState() => _AccountLoginPageState();
}

class _AccountLoginPageState extends State<AccountLoginPage> {

  TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          // 隐藏阴影
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 17,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Container(
          child: SingleChildScrollView(

            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: (){
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Text(
                      "请输入助记词",
                      style: TextStyle(color: Color(0xFF000000), fontSize: 24),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                    child: Text(
                      "助记词用于登录钱包,按照顺序将下方12个单词进行填写,单词之间使用空格填充",
                      style: TextStyle(color: Color(0xFF000000), fontSize: 14),
                    ),
                  ),


                  Center(
                    child: Container(
                      height: 170,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                      padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                      decoration: BoxDecoration(color: Color(0xFFEEEEEE), border: Border.all(color: Color(0xFFEEEEEE)), borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: TextField(
                        controller: _textEditingController,

                        style: TextStyle(
                          fontSize: 19,
                          color: Colors.black,
                        ),
                        maxLines: 10,
                        decoration: InputDecoration(
                          hintText: 'memory pool equip lesson limb naive endorse advice lift ...',
                          enabledBorder: new UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0x00000000)),
                          ),
// and:
                          focusedBorder: new UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0x00000000)),
                          ),
                          hintStyle: TextStyle(
                            fontSize: 19,
                            color: Colors.black.withAlpha(80),
                          ),
                        ),
                        cursorColor: Color(0xFFE71766),
                        cursorWidth: 2,
//                                cursorRadius: Radius.elliptical(20, 8),
                      ),
                    ),
                  ),
//              Container(
//                margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
//                width: MediaQuery.of(context).size.width,
//                child: Wrap(
//                  spacing: 10, //主轴上子控件的间距
//                  runSpacing: 10, //交叉轴上子控件之间的间距
//                  children: childrenFalse,
//                ),
//              ),
                  Container(
                    margin: const EdgeInsets.only(top: 30,bottom: 50),
                    child: ArgonButton(
                      height: 50,
                      roundLoadingShape: true,
                      width: MediaQuery.of(context).size.width * 0.8,
                      onTap: (startLoading, stopLoading, btnState) {
                        print("123");
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MnemonicConfirmPage()));
                      },
                      child: Text(
                        "确 认",
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      loader: Container(
                        padding: EdgeInsets.all(10),
                        child: SpinKitRing(
                          lineWidth: 4,
                          color: Colors.white,
                          // size: loaderWidth ,
                        ),
                      ),
                      borderRadius: 30.0,
                      color: Color(0xFFE71766),
                    ),
                  )
                ],
              ),
            )
          ),
        ));
  }
}