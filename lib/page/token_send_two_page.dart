import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:box/dao/account_info_dao.dart';
import 'package:box/dao/aens_register_dao.dart';
import 'package:box/dao/token_send_dao.dart';
import 'package:box/generated/l10n.dart';
import 'package:box/model/account_info_model.dart';
import 'package:box/model/aens_register_model.dart';
import 'package:box/model/token_send_model.dart';
import 'package:box/page/scan_page.dart';
import 'package:box/utils/utils.dart';
import 'package:box/widget/pay_password_widget.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter_qr_reader/flutter_qr_reader.dart';
import 'package:permission_handler/permission_handler.dart';

import '../main.dart';

class TokenSendTwoPage extends StatefulWidget {
  final String address;

  TokenSendTwoPage({Key key, @required this.address}) : super(key: key);

  @override
  _TokenSendTwoPageState createState() => _TokenSendTwoPageState();
}

class _TokenSendTwoPageState extends State<TokenSendTwoPage> {
  Flushbar flush;
  TextEditingController _textEditingController = TextEditingController();
  String token = "0";

  String address = '';

  @override
  void initState() {
    super.initState();
    netAccountInfo();
    getAddress();
  }

  void netAccountInfo() {
    AccountInfoDao.fetch().then((AccountInfoModel model) {
      if (model.code == 200) {
        print(model.data.balance);
        token = model.data.balance;
        setState(() {});
      } else {}
    }).catchError((e) {
      Fluttertoast.showToast(
          msg: "error" + e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFFAFAFA),
        appBar: AppBar(
          elevation: 0,
          brightness: Brightness.dark,
          backgroundColor: Color(0xFFFC2365),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 17,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            '',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Positioned(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 100,
                              color: Color(0xFFFC2365),
                            ),
                            Container(
                              decoration: new BoxDecoration(
                                gradient: const LinearGradient(
                                    begin: Alignment.topRight,
                                    colors: [
                                      Color(0xFFFC2365),
                                      Color(0xFFFAFAFA),
                                    ]),
                              ),
                              height: 200,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.only(
                                  left: 20, top: 10, right: 20),
                              child: Text(
                                S.of(context).token_send_two_page_title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Ubuntu",
                                  fontSize: 19,
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin:
                                      const EdgeInsets.only(left: 20, top: 10),
                                  child: Text(
                                    S.of(context).token_send_two_page_from,
                                    style: TextStyle(
                                      color: Colors.white.withAlpha(200),
                                      fontFamily: "Ubuntu",
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin:
                                      const EdgeInsets.only(left: 10, top: 10),
                                  child: Text(
                                    address,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Ubuntu",
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin:
                                      const EdgeInsets.only(left: 20, top: 10),
                                  child: Text(
                                    S.of(context).token_send_two_page_to,
                                    style: TextStyle(
                                      color: Colors.white.withAlpha(200),
                                      fontFamily: "Ubuntu",
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin:
                                      const EdgeInsets.only(left: 10, top: 10),
                                  child: Text(
                                    getReceiveAddress(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Ubuntu",
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.all(20),
                              height: 152,
                              //边框设置
                              decoration: new BoxDecoration(
                                  color: Color(0xE6FFFFFF),
                                  //设置四周圆角 角度
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(0.0, 15.0), //阴影xy轴偏移量
                                        blurRadius: 15.0, //阴影模糊程度
                                        spreadRadius: 1.0 //阴影扩散程度
                                        )
                                  ]
                                  //设置四周边框
                                  ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: const EdgeInsets.only(
                                        left: 18, top: 20),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            S
                                                .of(context)
                                                .token_send_two_page_number,
                                            style: TextStyle(
                                              color: Color(0xFF666666),
                                              fontFamily: "Ubuntu",
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: const EdgeInsets.only(
                                        left: 18, top: 0, right: 18),
                                    child: Stack(
                                      children: <Widget>[
                                        TextField(
//                                          autofocus: true,

                                          controller: _textEditingController,
                                          inputFormatters: [
                                            WhitelistingTextInputFormatter(
                                                RegExp("[0-9.]")), //只允许输入字母
                                          ],

                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 19,
                                            fontFamily: "Ubuntu",
                                            color: Colors.black,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: '',
                                            enabledBorder:
                                                new UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFFF6F6F6)),
                                            ),
                                            focusedBorder:
                                                new UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFFFC2365)),
                                            ),
                                            hintStyle: TextStyle(
                                              fontSize: 19,
                                              color: Colors.black.withAlpha(80),
                                            ),
                                          ),
                                          cursorColor: Color(0xFFFC2365),
                                          cursorWidth: 2,
//                                cursorRadius: Radius.elliptical(20, 8),
                                        ),
                                        Positioned(
                                          right: 0,
                                          top: 12,
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                left: 10, right: 0),
                                            child: Material(
                                              color: Color(0x00000000),
                                              child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(30)),
                                                  onTap: () {
                                                    _textEditingController
                                                        .text = token;
                                                    _textEditingController
                                                            .selection =
                                                        TextSelection.fromPosition(
                                                            TextPosition(
                                                                affinity:
                                                                    TextAffinity
                                                                        .downstream,
                                                                offset:
                                                                    _textEditingController
                                                                        .text
                                                                        .length));
                                                  },
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10),
                                                    height: 30,
                                                    child: Row(
                                                      children: <Widget>[
                                                        Container(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          S
                                                              .of(context)
                                                              .token_send_two_page_all,
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFFFC2365),
                                                            fontSize: 17,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 10,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.topLeft,
                                          margin:
                                              const EdgeInsets.only(left: 18),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  S
                                                      .of(context)
                                                      .token_send_two_page_balance,
                                                  style: TextStyle(
                                                    color: Color(0xFF666666),
                                                    fontFamily: "Ubuntu",
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, right: 18),
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            height: 30,
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  token + " AE",
                                                  style: TextStyle(
                                                    color: Color(0xFF666666),
                                                    fontFamily: "Ubuntu",
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30, bottom: 30),
                    child: ArgonButton(
                      height: 50,
                      roundLoadingShape: true,
                      width: MediaQuery.of(context).size.width * 0.8,
                      onTap: (startLoading, stopLoading, btnState) {
                        netSend(context, startLoading, stopLoading);
                      },
                      child: Text(
                        S.of(context).token_send_two_page_conform,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: "Ubuntu",
                            fontWeight: FontWeight.w700),
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
                      color: Color(0xFFFC2365),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
//
  }

  Future<String> getAddress() {
    BoxApp.getAddress().then((String address) {
      setState(() {
        this.address = Utils.formatAddress(address);
      });
    });
  }

  String getReceiveAddress() {
    return Utils.formatAddress(widget.address);
  }

  Future<void> netSend(
      BuildContext context, Function startLoading, Function stopLoading) async {
    //隐藏键盘
    startLoading();
    FocusScope.of(context).requestFocus(FocusNode());
    await Future.delayed(Duration(seconds: 1), () {
      showGeneralDialog(
          context: context,
          pageBuilder: (context, anim1, anim2) {},
          barrierColor: Colors.grey.withOpacity(.4),
          barrierDismissible: true,
          barrierLabel: "",
          transitionDuration: Duration(milliseconds: 400),
          transitionBuilder: (_, anim1, anim2, child) {
            final curvedValue =
                Curves.easeInOutBack.transform(anim1.value) - 1.0;
            return Transform(
                transform:
                    Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
                child: Opacity(
                  opacity: anim1.value,
                  // ignore: missing_return
                  child: PayPasswordWidget(
                      title: S.of(context).password_widget_input_password,
                      dismissCallBackFuture: (String password) {
                        stopLoading();
                        return;
                      },
                      passwordCallBackFuture: (String password) async {
                        var signingKey = await BoxApp.getSigningKey();
                        var address = await BoxApp.getAddress();
                        final key = Utils.generateMd5Int(password + address);
                        var aesDecode = Utils.aesDecode(signingKey, key);

                        if (aesDecode == "") {
                          showPlatformDialog(
                            context: context,
                            builder: (_) => BasicDialogAlert(
                              title:
                                  Text(S.of(context).dialog_hint_check_error),
                              content: Text(S
                                  .of(context)
                                  .dialog_hint_check_error_content),
                              actions: <Widget>[
                                BasicDialogAction(
                                  title: Text(
                                    S.of(context).dialog_conform,
                                    style: TextStyle(color: Color(0xFFFC2365)),
                                  ),
                                  onPressed: () {
                                    stopLoading();
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  },
                                ),
                              ],
                            ),
                          );
                          return;
                        }

                        TokenSendDao.fetch(_textEditingController.text,
                                widget.address, aesDecode)
                            .then((TokenSendModel model) {
                          stopLoading();
                          if (model.code == 200) {
                            showFlush(context);
                          } else {
                            showPlatformDialog(
                              context: context,
                              builder: (_) => BasicDialogAlert(
                                title: Text(
                                  S.of(context).dialog_hint_send_error,
                                ),
                                content: Text(model.msg),
                                actions: <Widget>[
                                  BasicDialogAction(
                                    title: Text(
                                      S.of(context).dialog_conform,
                                      style:
                                          TextStyle(color: Color(0xFFFC2365)),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          }
                        }).catchError((e) {
                          stopLoading();
                          Fluttertoast.showToast(
                              msg: "error",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        });
                      }),
                ));
          });
    });
  }

  void showFlush(BuildContext context) {
    flush = Flushbar<bool>(
      title: S.of(context).hint_broadcast_sucess,
      message: S.of(context).hint_broadcast_sucess_hint,
      backgroundGradient:
          LinearGradient(colors: [Color(0xFFFC2365), Color(0xFFFC2365)]),
      backgroundColor: Color(0xFFFC2365),
      blockBackgroundInteraction: true,
      flushbarPosition: FlushbarPosition.BOTTOM,
      //                        flushbarStyle: FlushbarStyle.GROUNDED,

      mainButton: FlatButton(
        onPressed: () {
          flush.dismiss(true); // result = true
        },
        child: Text(
          S.of(context).dialog_conform,
          style: TextStyle(color: Colors.white),
        ),
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.black.withAlpha(80),
          offset: Offset(0.0, 2.0),
          blurRadius: 13.0,
        )
      ],
    )..show(context).then((result) {
        Navigator.pop(context);
      });
  }
}