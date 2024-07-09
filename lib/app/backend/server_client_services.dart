import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../utils/prefferences.dart';

class ServerClient {
  static const int _timeout = 180;

  /// Get request

  static Future<List> get(String url) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "appId": "660273733e5ec840c5ca3e43",
      "country": AppPref.country.trim().isEmpty ? "" : AppPref.country,
    };
    log("Bearer $url");
    if (AppPref.userToken.isNotEmpty) {
      headers["authorization"] = "Bearer ${AppPref.userToken}";
      log("Bearer ${AppPref.userToken}");
    }
    try {
      var response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: _timeout));

      return _response(response);
    } on SocketException {
      return [600, "No internet"];
    } catch (e) {
      return [600, e.toString()];
    }
  }

  /// Post request

  static Future<List> post(
    String url, {
    Map<String, dynamic>? data,
    bool post = true,
  }) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "appId": "660273733e5ec840c5ca3e43",
      "country": AppPref.country.trim().isEmpty ? "" : AppPref.country,
    };
    if (AppPref.userToken.isNotEmpty) {
      headers["authorization"] = "Bearer ${AppPref.userToken}";
    }

    try {
      var body = json.encode(data);
      var response = await http
          .post(Uri.parse(url), body: post ? body : null, headers: headers)
          .timeout(const Duration(seconds: _timeout));
      return _response(response);
    } on SocketException {
      return [600, "No internet"];
    } catch (e) {
      return [600, e.toString()];
    }
  }

  /// Put request

  static Future<List> put(
    String url, {
    Map<String, dynamic>? data,
    bool put = false,
  }) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "appId": "660273733e5ec840c5ca3e43",
      "country": AppPref.country.trim().isEmpty ? "" : AppPref.country,
    };
    if (AppPref.userToken.isNotEmpty) {
      headers["authorization"] = "Bearer ${AppPref.userToken}";
    }
    try {
      String? body = json.encode(data);
      var response = await http
          .put(Uri.parse(url), body: put ? null : body, headers: headers)
          .timeout(const Duration(seconds: _timeout));
      return _response(response);
    } on SocketException {
      return [600, "No internet"];
    } catch (e) {
      return [600, e.toString()];
    }
  }

  /// Delete request

  static Future<List> delete(
    String url, {
    Map<String, dynamic>? data,
  }) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "appId": "660273733e5ec840c5ca3e43",
      "country": AppPref.country.trim().isEmpty ? "" : AppPref.country,
    };
    if (AppPref.userToken.isNotEmpty) {
      headers["authorization"] = "Bearer ${AppPref.userToken}";
    }
    String? jsonData = data != null ? json.encode(data) : null;

    var response =
        await http.delete(Uri.parse(url), headers: headers, body: jsonData);
    return await _response(response);
  }

  // ------------------- ERROR HANDLING ------------------- \\

  static Future<List> _response(http.Response response) async {
    switch (response.statusCode) {
      case 200:
        return [response.statusCode, jsonDecode(response.body)];
      case 201:
        return [response.statusCode, jsonDecode(response.body)];
      case 400:
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 401:
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 403:
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 404:
        return [response.statusCode, "You're using unregistered application"];
      case 500:
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 502:
        return [response.statusCode, "Server Crashed or under maintenance"];
      case 503:
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 504:
        return [
          response.statusCode,
          {"message": "Request timeout", "code": 504, "status": "Cancelled"}
        ];
      default:
        return [response.statusCode, jsonDecode(response.body)["message"]];
    }
  }
}
