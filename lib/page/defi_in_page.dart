import 'dart:convert';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:box/dao/account_info_dao.dart';
import 'package:box/dao/aens_register_dao.dart';
import 'package:box/dao/contract_balance_dao.dart';
import 'package:box/dao/contract_transfer_call_dao.dart';
import 'package:box/dao/token_send_dao.dart';
import 'package:box/dao/tx_broadcast_dao.dart';
import 'package:box/event/language_event.dart';
import 'package:box/generated/l10n.dart';
import 'package:box/model/msg_sign_model.dart';
import 'package:box/model/account_info_model.dart';
import 'package:box/model/aens_register_model.dart';
import 'package:box/model/contract_balance_model.dart';
import 'package:box/model/contract_call_model.dart';
import 'package:box/model/token_send_model.dart';
import 'package:box/page/scan_page.dart';
import 'package:box/utils/utils.dart';
import 'package:box/widget/chain_loading_widget.dart';
import 'package:box/widget/pay_password_widget.dart';
import 'package:box/widget/tx_conform_widget.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter_qr_reader/flutter_qr_reader.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:permission_handler/permission_handler.dart';

import '../main.dart';
import 'home_page.dart';

class DefiInPage extends StatefulWidget {
  DefiInPage({Key key}) : super(key: key);

  @override
  _DefiInPageState createState() => _DefiInPageState();
}

class _DefiInPageState extends State<DefiInPage> {
  Flushbar flush;
  TextEditingController _textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  String address = '';
  String currentCoinName = 'AE';

  @override
  void initState() {
    super.initState();
    netAccountInfo();
    netContractBalance();
    getAddress();
  }

  void netContractBalance() {
    ContractBalanceDao.fetch().then((ContractBalanceModel model) {
      if (model.code == 200) {
        HomePage.tokenABC = model.data.balance;
        setState(() {});
      } else {}
    }).catchError((e) {
//      Fluttertoast.showToast(msg: "网络错误" + e.toString(), toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, backgroundColor: Colors.black, textColor: Colors.white, fontSize: 16.0);
    });
  }

  void netAccountInfo() {
    AccountInfoDao.fetch().then((AccountInfoModel model) {
      if (model.code == 200) {
        print(model.data.balance);
        HomePage.token = model.data.balance;
        setState(() {});
      } else {}
    }).catchError((e) {
      Fluttertoast.showToast(msg: "error" + e.toString(), toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, backgroundColor: Colors.black, textColor: Colors.white, fontSize: 16.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFeeeeee),
        appBar: AppBar(
          elevation: 0,
          brightness: Brightness.dark,
          backgroundColor: Color(0xff3460ee),
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
                              height: 150,
                              color: Color(0xff3460ee),
                            ),
                            Container(
                              decoration: new BoxDecoration(
                                gradient: const LinearGradient(begin: Alignment.topRight, colors: [
                                  Color(0xff3460ee),
                                  Color(0xFFEEEEEE),
                                ]),
                              ),
                              height: 190,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.only(left: 20, top: 10, right: 20),
                              child: Text(
                                S.of(context).defi_card_in_title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: BoxApp.language == "cn" ? "Ubuntu":"Ubuntu",
                                  fontSize: 19,
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: const EdgeInsets.only(left: 20, top: 10),
                                  child: Text(
                                    S.of(context).token_send_two_page_from,
                                    style: TextStyle(
                                      color: Colors.white.withAlpha(200),
                                      fontFamily: BoxApp.language == "cn" ? "Ubuntu":"Ubuntu",
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: const EdgeInsets.only(left: 10, top: 10),
                                  child: Text(
                                    Utils.formatAddress(address),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: BoxApp.language == "cn" ? "Ubuntu":"Ubuntu",
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
                                  margin: const EdgeInsets.only(left: 20, top: 10),
                                  child: Text(
                                    S.of(context).token_send_two_page_to,
                                    style: TextStyle(
                                      color: Colors.white.withAlpha(200),
                                      fontFamily: BoxApp.language == "cn" ? "Ubuntu":"Ubuntu",
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: const EdgeInsets.only(left: 10, top: 10),
                                  child: Text(
                                    Utils.formatCTAddress(BoxApp.DEFI_CONTRACT_V2),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: BoxApp.language == "cn" ? "Ubuntu":"Ubuntu",
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.all(20),
                              height: 172,
                              //边框设置
                              decoration: new BoxDecoration(
                                  color: Color(0xE6FFFFFF),
                                  //设置四周圆角 角度
                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  boxShadow: [
//                                    BoxShadow(
//                                        color: Colors.black12,
//                                        offset: Offset(0.0, 15.0), //阴影xy轴偏移量
//                                        blurRadius: 15.0, //阴影模糊程度
//                                        spreadRadius: 1.0 //阴影扩散程度
//                                        )
                                  ]
                                  //设置四周边框
                                  ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: const EdgeInsets.only(left: 18, top: 20),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            S.of(context).defi_card_in_title_content,
                                            style: TextStyle(
                                              color: Color(0xFF666666),
                                              fontFamily: BoxApp.language == "cn" ? "Ubuntu":"Ubuntu",
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: const EdgeInsets.only(left: 18, top: 0, right: 18),
                                    child: Stack(
                                      children: <Widget>[
                                        TextField(
//                                          autofocus: true,

                                          controller: _textEditingController,
                                          focusNode: focusNode,
                                          inputFormatters: [
                                            WhitelistingTextInputFormatter(RegExp("[0-9.]")), //只允许输入字母
                                          ],

                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 19,
                                            fontFamily: BoxApp.language == "cn" ? "Ubuntu":"Ubuntu",
                                            color: Colors.black,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: '',
                                            enabledBorder: new UnderlineInputBorder(
                                              borderSide: BorderSide(color: Color(0xFFeeeeee)),
                                            ),
                                            focusedBorder: new UnderlineInputBorder(
                                              borderSide: BorderSide(color: Color(0xff3460ee)),
                                            ),
                                            hintStyle: TextStyle(
                                              fontSize: 19,
                                              color: Colors.black.withAlpha(80),
                                            ),
                                          ),
                                          cursorColor: Color(0xff3460ee),
                                          cursorWidth: 2,
//                                cursorRadius: Radius.elliptical(20, 8),
                                        ),
                                        Positioned(
                                          right: 0,
                                          top: 12,
                                          child: Container(
                                            height: 30,
                                            margin: const EdgeInsets.only(right: 0),
                                            child: FlatButton(
                                              onPressed: () {
                                                clickAllCount();
                                              },
                                              child: Text(
                                                S.of(context).token_send_two_page_all,
                                                maxLines: 1,
                                                style: TextStyle(fontSize: 13, fontFamily: BoxApp.language == "cn" ? "Ubuntu":"Ubuntu", color: Color(0xff3460ee)),
                                              ),
                                              color: Color(0xff3460ee).withAlpha(40),
                                              textColor: Colors.black,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 10,
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      child: Container(
                                        height: 55,
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: <Widget>[
                                            Container(
                                              padding: const EdgeInsets.only(left: 18),
                                              child: Row(
                                                children: <Widget>[
                                                  Container(
                                                    width: 36.0,
                                                    height: 36.0,
                                                    decoration: BoxDecoration(
                                                      border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1.0), top: BorderSide(color: Color(0xFFEEEEEE), width: 1.0), left: BorderSide(color: Color(0xFFEEEEEE), width: 1.0), right: BorderSide(color: Color(0xFFEEEEEE), width: 1.0)),
//                                                      shape: BoxShape.rectangle,
                                                      borderRadius: BorderRadius.circular(36.0),
                                                      image: DecorationImage(
                                                        image: AssetImage(currentCoinName == "AE" ? "images/apple-touch-icon.png" : "images/logo.png"),
//                                                        image: AssetImage("images/apple-touch-icon.png"),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets.only(left: 15),
                                                    child: Text(
                                                      currentCoinName,
                                                      style: new TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w600,
                                                        fontFamily: BoxApp.language == "cn" ? "Ubuntu":"Ubuntu",
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              right: 28,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    currentCoinName == "AE" ? HomePage.token + " " : HomePage.tokenABC + " ",
                                                    style: TextStyle(
                                                      color: Color(0xFF666666),
                                                      fontFamily: BoxApp.language == "cn" ? "Ubuntu":"Ubuntu",
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
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
                    margin: const EdgeInsets.only(top: 0),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: FlatButton(
                        onPressed: () {
                          netSendV2(context);
                        },
                        child: Text(
                          S.of(context).token_send_two_page_conform,
                          maxLines: 1,
                          style: TextStyle(fontSize: 16, fontFamily: BoxApp.language == "cn" ? "Ubuntu":"Ubuntu", color: Color(0xffffffff)),
                        ),
                        color: Color(0xff3460ee),
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
//
  }
  void clickAllCount() {
    if (currentCoinName == "AE") {
      if (HomePage.token == "loading...") {
        _textEditingController.text = "0";
      } else {
        if (double.parse(HomePage.token) < 1) {
          _textEditingController.text = "0";
        } else {
          _textEditingController.text = (double.parse(HomePage.token) - 1).toString();
        }
      }
    } else {
      if (HomePage.tokenABC == "loading...") {
        _textEditingController.text = "0";
      } else {
        if (double.parse(HomePage.tokenABC) < 1) {
          _textEditingController.text = "0";
        } else {
          _textEditingController.text = (double.parse(HomePage.tokenABC) - 1).toString();
        }
      }
      _textEditingController.selection = TextSelection.fromPosition(TextPosition(affinity: TextAffinity.downstream, offset: _textEditingController.text.length));
    }
  }

  Future<String> getAddress() {
    BoxApp.getAddress().then((String address) {
      setState(() {
        this.address = address;
      });
    });
  }

  Future<void> netSendV2(BuildContext context) async {
    focusNode.unfocus();
    var senderID = await BoxApp.getAddress();
    if (currentCoinName == "AE") {
//      startLoading();
      showGeneralDialog(
          context: context,
          // ignore: missing_return
          pageBuilder: (context, anim1, anim2) {},
          barrierColor: Colors.grey.withOpacity(.4),
          barrierDismissible: true,
          barrierLabel: "",
          transitionDuration: Duration(milliseconds: 400),
          transitionBuilder: (_, anim1, anim2, child) {
            final curvedValue = Curves.easeInOutBack.transform(anim1.value) - 1.0;
            return Transform(
              transform: Matrix4.translationValues(0.0, 0, 0.0),
              child: Opacity(
                opacity: anim1.value,
                // ignore: missing_return
                child: PayPasswordWidget(
                  title: S.of(context).password_widget_input_password,
                  dismissCallBackFuture: (String password) {

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
                          title: Text(S.of(context).dialog_hint_check_error),
                          content: Text(S.of(context).dialog_hint_check_error_content),
                          actions: <Widget>[
                            BasicDialogAction(
                              title: Text(
                                S.of(context).dialog_conform,
                                style: TextStyle(color: Color(0xff3460ee)),
                              ),
                              onPressed: () {

                                Navigator.of(context, rootNavigator: true).pop();
                              },
                            ),
                          ],
                        ),
                      );
                      return;
                    }
                    // ignore: missing_return
                    BoxApp.contractDefiV2Lock((tx) {
                      eventBus.fire(DefiEvent());
                      showFlushSucess(context);

                      // ignore: missing_return
                    }, (error) {
                      showPlatformDialog(
                        context: context,
                        builder: (_) => BasicDialogAlert(
                          title: Text(S.of(context).dialog_hint_check_error),
                          content: Text(error),
                          actions: <Widget>[
                            BasicDialogAction(
                              title: Text(
                                S.of(context).dialog_conform,
                                style: TextStyle(
                                  color: Color(0xff3460ee),
                                  fontFamily: BoxApp.language == "cn" ? "Ubuntu":"Ubuntu",
                                ),
                              ),
                              onPressed: () {

                                Navigator.of(context, rootNavigator: true).pop();
                              },
                            ),
                          ],
                        ),
                      );

                    }, aesDecode, address, BoxApp.DEFI_CONTRACT_V2, _textEditingController.text);
                    showChainLoading();
                  },
                ),
              ),
            );
          });
    } else {
//      startLoading();
      showGeneralDialog(
          context: context,
          // ignore: missing_return
          pageBuilder: (context, anim1, anim2) {},
          barrierColor: Colors.grey.withOpacity(.4),
          barrierDismissible: true,
          barrierLabel: "",
          transitionDuration: Duration(milliseconds: 400),
          transitionBuilder: (_, anim1, anim2, child) {
            final curvedValue = Curves.easeInOutBack.transform(anim1.value) - 1.0;
            return Transform(
              transform: Matrix4.translationValues(0.0, 0, 0.0),
              child: Opacity(
                opacity: anim1.value,
                // ignore: missing_return
                child: PayPasswordWidget(
                  title: S.of(context).password_widget_input_password,
                  dismissCallBackFuture: (String password) {

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
                          title: Text(S.of(context).dialog_hint_check_error),
                          content: Text(S.of(context).dialog_hint_check_error_content),
                          actions: <Widget>[
                            BasicDialogAction(
                              title: Text(
                                S.of(context).dialog_conform,
                                style: TextStyle(
                                  color: Color(0xff3460ee),
                                  fontFamily: BoxApp.language == "cn" ? "Ubuntu":"Ubuntu",
                                ),
                              ),
                              onPressed: () {

                                Navigator.of(context, rootNavigator: true).pop();
                              },
                            ),
                          ],
                        ),
                      );
                      return;
                    }
                    // ignore: missing_return
                    BoxApp.contractTransfer((tx) {
                      showFlushSucess(context);

                      // ignore: missing_return
                    }, (error) {
                      showPlatformDialog(
                        context: context,
                        builder: (_) => BasicDialogAlert(
                          title: Text(S.of(context).dialog_hint_check_error),
                          content: Text(error),
                          actions: <Widget>[
                            BasicDialogAction(
                              title: Text(
                                S.of(context).dialog_conform,
                                style: TextStyle(
                                  color: Color(0xff3460ee),
                                  fontFamily: BoxApp.language == "cn" ? "Ubuntu":"Ubuntu",
                                ),
                              ),
                              onPressed: () {

                                Navigator.of(context, rootNavigator: true).pop();
                              },
                            ),
                          ],
                        ),
                      );

                      // ignore: missing_return
                    }, aesDecode, address, BoxApp.DEFI_CONTRACT_V2, "", _textEditingController.text);
                    showChainLoading();
                  },
                ),
              ),
            );
          });
    }
  }

  void showChainLoading() {
    showGeneralDialog(
        context: context,
        // ignore: missing_return
        pageBuilder: (context, anim1, anim2) {},
        barrierColor: Colors.grey.withOpacity(.4),
        barrierDismissible: true,
        barrierLabel: "",
        transitionDuration: Duration(milliseconds: 400),
        transitionBuilder: (_, anim1, anim2, child) {
          final curvedValue = Curves.easeInOutBack.transform(anim1.value) - 1.0;
          return ChainLoadingWidget();
        });
  }

  void showFlushSucess(BuildContext context) {
    flush = Flushbar<bool>(
      title: S.of(context).hint_broadcast_sucess,
      message: S.of(context).hint_broadcast_sucess_hint,
      backgroundGradient: LinearGradient(colors: [Color(0xff3460ee), Color(0xff3460ee)]),
      backgroundColor: Color(0xff3460ee),
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
