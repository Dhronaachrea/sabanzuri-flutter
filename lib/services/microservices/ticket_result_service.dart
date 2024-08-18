import 'package:sabanzuri/utils/app_constants.dart';
import 'package:sabanzuri/utils/url.dart';

import 'package:sabanzuri/model/ige_game_model.dart';
import 'package:sabanzuri/services/api_service.dart';

class TicketResultService {
  static var headers = {
    'Content-Type': 'application/json',
  };

  static Future<IgeGameModel?> fetchIgeGame() async {
    var request = {
      "service": "B2C",
    };
    final response = await ApiService.makeRequest(
        Url.FETCH_IGE_GAME_URL, RequestType.post, request, headers);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');

    return IgeGameModel.fromJson(jsonMap);
  }
}
