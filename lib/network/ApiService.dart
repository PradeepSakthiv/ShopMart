import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shop_mart/models/HandShake.dart';
import 'package:shop_mart/network/ApiModel.dart';
import 'ApiConstants.dart';
import 'Logger.dart';

class ApiService {
  final LoggerFile loggerFile = new LoggerFile();

  Future getHeader() async {
    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    return header;
  }

  Future<List<ApiModel>?> getUsers() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<ApiModel> _model = userModelFromJson(response.body);
        loggerFile.logDisplay(response.body.toString());

        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  // Get data by GET Method
  Future getTestData() async {
    try {
      var url = Uri.parse(ApiConstants.testBaseUrl + ApiConstants.weather);
      var response = await http.get(url);
      // loggerFile.logDisplay(response.body.toString());
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  // Get data by POST Method
  Future<HandShakeModel?> getTestDataPost() async {
    try {
      var url = Uri.parse(ApiConstants.testBaseUrl + ApiConstants.handshake);
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'language': 'en',
        }),
      );

      if (response.statusCode == 200) {
        HandShakeModel _model = handShakeFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<HandShakeModel?> getTerm(String term) async {
    try {
      var url =
          Uri.parse(ApiConstants.testBaseUrl + ApiConstants.handshakeTerms);
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: term,
      );

      loggerFile.logDisplay(term);
      loggerFile.logDisplay(response.body.toString());

    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
