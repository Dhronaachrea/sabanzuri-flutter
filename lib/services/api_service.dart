import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/utils/utils.dart';
import 'package:sabanzuri/widgets/bottom_sheet.dart';
import 'package:sabanzuri/widgets/bottom_sheet_home_lobby.dart';
import 'package:velocity_x/velocity_x.dart';

enum RequestType { get, post, put }

class ApiService {
  static bool showLog = true;
  static bool showColorLog = false;

  static Future<Response?> makeRequest(
    String url,
    RequestType requestType,
    dynamic parameter,
    dynamic headers,
  ) async {
    var client = Client();
    switch (requestType) {
      case RequestType.get:
        try {
          String queryString = Uri(queryParameters: parameter).query;
          final Response response = await client.get(
            Uri.parse('$url?$queryString'),
            headers: headers,
          );


          print("getting response------------>${response.body}");
          printLog("GET", "$url?$queryString", headers, parameter, response);

          return onResponseReceive(response);
        } catch (e) {
          log("$url : $e");
        }
        break;

      case RequestType.post:
        try {
          final Response response = await client.post(
            Uri.parse(url),
            headers: headers,
            body: jsonEncode(parameter),
          );

          printLog("POST", url, headers, parameter, response);

          return onResponseReceive(response);
        } catch (e) {
          log("$url : $e");
        }
        break;

      case RequestType.put:
        try {
          final Response response = await client.put(
            Uri.parse(url),
            headers: headers,
            body: jsonEncode(parameter),
          );

          printLog("PUT", url, headers, parameter, response);
          return onResponseReceive(response);
        } catch (e) {
          log("$url : $e");
        }
        break;
      default:
        return throw Exception("The HTTP request method is not found");
    }
    return null;
  }

  static Future makeMultipartRequest(
    String url,
    dynamic parameter,
    dynamic headers,
    Iterable<MultipartFile>? files,
  ) async {
    try {
      final request = MultipartRequest(
        'POST',
        Uri.parse(url),
      );
      request.fields.addAll(parameter);
      request.headers.addAll(headers);
      if (files != null) {
        request.files.addAll(files);
        for (var i in files) {
          log("\x1B[36m${i.field}: ${i.filename}\x1B[0m");
        }
      }
      logMultipartApi("MULTIPART POST", url, headers, parameter);
      StreamedResponse? streamResponse = await request.send();
      Response? response = await Response.fromStream(streamResponse);
      if (response.statusCode == 200) {
        log("\n Response: ${response.body}");
        return response;
      } else {
        throw Exception(streamResponse.stream.bytesToString());
      }
    } catch (e) {
      log("$url : $e");
    }
  }

  static printLog(
    type,
    url,
    headers,
    parameter,
    response,
  ) {
    if (showLog) {
      if (showColorLog) {
        logApi("$type", url, headers, parameter, response);
      } else {
        log("[$type] $url \nHeaders: $headers \nRequest: ${jsonEncode(parameter)}\nResponse: ${response.body}");
      }
    }
  }

  static onResponseReceive(Response response) {
    // if (response.statusCode == 200) {
    //   return response;
    // } else {
    //   throw Exception(response.statusCode);
    // }
    return response;
  }

  static logApi(
    dynamic type,
    String url,
    dynamic headers,
    dynamic parameter,
    dynamic response,
  ) {
    log("\x1B[35m[$type] $url\x1B[0m \x1B[34m\nHeaders: $headers\x1B[0m  \x1B[36m\nRequest: ${jsonEncode(parameter).toString()}\n\x1B[0m Response: ${response.body}");
  }

  static logMultipartApi(
    dynamic type,
    String url,
    dynamic headers,
    dynamic parameter,
  ) {
    log("\x1B[35m[$type] $url\x1B[0m \x1B[34m\nHeaders: $headers\x1B[0m  \x1B[36m\nRequest: ${jsonEncode(parameter).toString()}");
  }

  static getResponse(Response? response, String screenName) {
    dynamic sessionExpiryCode = 203;
    String? errorCodeKey = "errorCode";
    String? jsonString = response?.body;
    // if (jsonString == null) return null;
    Map<String, dynamic> jsonMap = {};
    try {
      jsonMap = jsonDecode(jsonString!);
    } catch (e) {
      jsonMap = {errorCodeKey: -1};
    }

    int? errorCode = jsonMap[errorCodeKey];

    /*if (jsonString == null) {
      if (GlobleVariables.isInternetAvailability == true) {
        _showErrorSheet('No internet connection...', screenName);
        GlobleVariables.isInternetAvailability = false;
      }
    }*/

    if (errorCode != null && errorCode == sessionExpiryCode) {
      showSessionExpiredDialog();
    }
    return jsonMap;
  }

  static showErrorSheet() {
    displayModalBottomSheet(
      navigatorKey.currentContext!,
      MyBottomSheet(
        wrapContent: true,
        image: const AssetImage("assets/images/internet.png"),
        heading: 'Oh No! No Internet',
        onWillPop: () async {
          return false;
        },
        description: [
          Center(
            child: const Text(
              "Please turn on internet to continue.",
              style: TextStyle(
                color: SabanzuriColors.lightish_red,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ).pOnly(bottom: 100),
          )
        ],
      ),
    );
  }

  static showErrorSheetHomeLobby() {
    displayModalBottomSheetHomeLobby(
      navigatorKey.currentContext!,
      MyBottomSheetHomeLobby(
        wrapContent: true,
        image: const AssetImage("assets/images/internet.png"),
        heading: 'Oh No! No Internet',
        onWillPop: () async {
          return false;
        },
        description: [
          Center(
            child: const Text(
              "Please turn on internet to continue.",
              style: TextStyle(
                color: SabanzuriColors.lightish_red,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ).pOnly(bottom: 100),
          )
        ],
      ),
    );
  }
}
