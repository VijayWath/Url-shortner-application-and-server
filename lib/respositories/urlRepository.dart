import 'dart:convert';

import 'package:url_shortner_service/models/historyModel.dart';
import 'package:url_shortner_service/models/responseModel.dart';
import 'package:http/http.dart' as http;
import 'package:url_shortner_service/models/urlModel.dart';
import 'package:url_shortner_service/respositories/tokenRepository.dart';

class UrlRepository {
  final host = 'http://192.168.29.220:3000';
  Future<ResponseModel> createNewUrl({uid, orignalUrl}) async {
    try {
      final token = await TokenRepository().getToken();
      final _response = await http.post(
        Uri.parse("$host/api/"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': '$token'
        },
      );
      if (_response.statusCode == 200) {
        String shortId = jsonDecode(_response.body)["id"];
        UrlModel url = UrlModel(
          shortId: shortId.toString(),
          redirectUrl: orignalUrl.toString(),
          userId: uid.toString(),
        );
        return ResponseModel(data: url, error: null);
      }

      if (_response.statusCode == 500) {
        return ResponseModel(
            data: null, error: "Something went wrong in server");
      }
      if (_response.statusCode == 400) {
        String error = jsonDecode(_response.body)["error"];
        return ResponseModel(data: null, error: error.toString());
      }
      return ResponseModel(
          data: null, error: "Something went wrong in creating url");
    } catch (e) {
      return ResponseModel(
          data: null, error: "Something catched in creating url");
    }
  }

  Future<ResponseModel> getUrlHistory(String urlShortId) async {
    try {
      final token = await TokenRepository().getToken();
      final _response = await http.post(
        Uri.parse("$host/api/analytics/$urlShortId"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': '$token'
        },
      );

      if (_response.statusCode == 200) {
        List res = jsonDecode(_response.body)["visitHistory"];
        List<HistoryModel> historyList = [];
        res.forEach((element) {
          DateTime date = DateTime.fromMicrosecondsSinceEpoch(
              int.parse(element["timestamps"]));
          HistoryModel history =
              HistoryModel(ip: element["requestIP"].toString(), date: date);
          historyList.add(history);
        });
        return ResponseModel(data: historyList, error: null);
      }

      if (_response.statusCode == 500) {
        return ResponseModel(
            data: null, error: "Something went wrong in server");
      }
      return ResponseModel(
          data: null, error: "Something went wrong in creating url");
    } catch (e) {
      return ResponseModel(
          data: null, error: "Something catched in creating url");
    }
  }

  Future<ResponseModel> getAllurls(token) async {
    try {
      final _response = await http.get(
        Uri.parse("$host/api/user/allurl"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': '$token'
        },
      );

      if (_response.statusCode == 200) {
        List<UrlModel> urlList = [];
        final res = jsonDecode(_response.body)["urlList"];
        res.forEach(
          (element) {
            UrlModel url = UrlModel(
                shortId: element["shortId"].toString(),
                redirectUrl: element["redirectUrl"].toString(),
                userId: element["userId"].toString());
            urlList.add(url);
          },
        );
        return ResponseModel(data: urlList, error: null);
      }

      if (_response.statusCode == 500) {
        return ResponseModel(
            data: null, error: "Something went wrong in server");
      }
      return ResponseModel(
          data: null, error: "Something went wrong in creating url");
    } catch (e) {
      return ResponseModel(
          data: null, error: "Something catched in getting all urls");
    }
  }
}
