import 'package:sabanzuri/model/dge_game_model.dart';
import 'package:sabanzuri/utils/url.dart';

import 'package:sabanzuri/services/api_service.dart';

class BaseService {
  static var headers = {
    'Content-Type': 'application/json',
  };

  static Future<DgeGameModel?> fetchDgeGame(String screenName) async {
    Map<String, String> params = {"deviceType": "MOBILE"};
    final response = await ApiService.makeRequest(
        Url.FETCH_DGE_GAME_URL, RequestType.post, params, headers);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, screenName);

    return DgeGameModel.fromJson(jsonMap);
  }
}
