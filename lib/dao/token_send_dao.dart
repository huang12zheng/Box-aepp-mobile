import 'dart:convert';

import 'package:box/dao/urls.dart';
import 'package:box/main.dart';
import 'package:box/model/msg_sign_model.dart';
import 'package:box/model/aens_register_model.dart';
import 'package:box/model/block_top_model.dart';
import 'package:box/model/token_send_model.dart';
import 'package:dio/dio.dart';

class TokenSendDao {
  static Future<MsgSignModel> fetch(String amount, String senderID,String recipientID) async {
    Map<String, String> params = new Map();
    params['amount'] = amount;
    params['senderID'] = senderID;
    params['recipientID'] = recipientID;
    params['data'] = "Box aepp";
    Response response = await Dio().post(WALLET_TRANSFER, queryParameters: params);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.toString());
      MsgSignModel model = MsgSignModel.fromJson(data);
      return model;
    } else {
      throw Exception('Failed to load TokenSendModel.json');
    }
  }
}
