import 'dart:convert';

GameModel gameModelFromJson(String str) => GameModel.fromJson(json.decode(str));

String gameModelToJson(GameModel data) => json.encode(data.toJson());

class GameModel {
  GameModel({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  int? responseCode;
  String? responseMessage;
  ResponseData? responseData;

  factory GameModel.fromJson(Map<String, dynamic> json) => GameModel(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    responseData: json["responseData"] != null
        ? ResponseData.fromJson(json["responseData"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
    "responseData": responseData?.toJson(),
  };
}

class ResponseData {
  ResponseData({
    required this.gameRespVOs,
    required this.currentDate,
  });

  List<GameRespVo> gameRespVOs;
  DateTime currentDate;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    gameRespVOs: List<GameRespVo>.from(
        json["gameRespVOs"].map((x) => GameRespVo.fromJson(x))),
    currentDate: DateTime.parse(json["currentDate"]),
  );

  Map<String, dynamic> toJson() => {
    "gameRespVOs": List<dynamic>.from(gameRespVOs.map((x) => x.toJson())),
    "currentDate": currentDate.toIso8601String(),
  };
}

class GameRespVo {
  GameRespVo({
    required this.id,
    required this.gameNumber,
    required this.gameName,
    required this.gameCode,
    required this.betLimitEnabled,
    required this.familyCode,
    required this.lastDrawResult,
    required this.displayOrder,
    required this.drawFrequencyType,
    required this.timeToFetchUpdatedGameInfo,
    required this.numberConfig,
    required this.betRespVOs,
    required this.drawRespVOs,
    required this.nativeCurrency,
    required this.drawEvent,
    required this.gameStatus,
    required this.gameOrder,
    required this.consecutiveDraw,
    required this.maxAdvanceDraws,
    required this.drawPrizeMultiplier,
    required this.lastDrawFreezeTime,
    required this.lastDrawDateTime,
    required this.lastDrawSaleStopTime,
    required this.lastDrawTime,
    required this.ticketExpiry,
    required this.lastDrawWinningResultVOs,
    required this.maxPanelAllowed,
    required this.gameSchemas,
    required this.resultConfigData,
    required this.donation,
    required this.jackpotAmount,
    required this.unitCost,
  });

  int id;
  int gameNumber;
  String gameName;
  String gameCode;
  String betLimitEnabled;
  String familyCode;
  String lastDrawResult;
  String displayOrder;
  String drawFrequencyType;
  String timeToFetchUpdatedGameInfo;
  NumberConfig numberConfig;
  List<BetRespVo> betRespVOs;
  List<DrawRespVo> drawRespVOs;
  String nativeCurrency;
  String drawEvent;
  String gameStatus;
  String gameOrder;
  String consecutiveDraw;
  int maxAdvanceDraws;
  DrawPrizeMultiplier drawPrizeMultiplier;
  String lastDrawFreezeTime;
  String lastDrawDateTime;
  String lastDrawSaleStopTime;
  String lastDrawTime;
  int ticketExpiry;
  List<LastDrawWinningResultVo> lastDrawWinningResultVOs;
  int maxPanelAllowed;
  GameSchemas gameSchemas;
  ResultConfigData resultConfigData;
  List<Donation> donation;
  dynamic jackpotAmount;
  List<UnitCost>? unitCost;

  factory GameRespVo.fromJson(Map<String, dynamic> json) => GameRespVo(
    id: json["id"],
    gameNumber: json["gameNumber"],
    gameName: json["gameName"],
    gameCode: json["gameCode"],
    betLimitEnabled: json["betLimitEnabled"],
    familyCode: json["familyCode"],
    lastDrawResult: json["lastDrawResult"],
    displayOrder: json["displayOrder"],
    drawFrequencyType: json["drawFrequencyType"],
    timeToFetchUpdatedGameInfo: json["timeToFetchUpdatedGameInfo"],
    numberConfig: NumberConfig.fromJson(json["numberConfig"]),
    betRespVOs: List<BetRespVo>.from(
        json["betRespVOs"].map((x) => BetRespVo.fromJson(x))),
    drawRespVOs: List<DrawRespVo>.from(
        json["drawRespVOs"].map((x) => DrawRespVo.fromJson(x))),
    nativeCurrency: json["nativeCurrency"],
    drawEvent: json["drawEvent"],
    gameStatus: json["gameStatus"],
    gameOrder: json["gameOrder"],
    consecutiveDraw: json["consecutiveDraw"],
    maxAdvanceDraws: json["maxAdvanceDraws"],
    drawPrizeMultiplier:
    DrawPrizeMultiplier.fromJson(json["drawPrizeMultiplier"]),
    lastDrawFreezeTime: json["lastDrawFreezeTime"],
    lastDrawDateTime: json["lastDrawDateTime"],
    lastDrawSaleStopTime: json["lastDrawSaleStopTime"],
    lastDrawTime: json["lastDrawTime"],
    ticketExpiry: json["ticket_expiry"],
    lastDrawWinningResultVOs: List<LastDrawWinningResultVo>.from(
        json["lastDrawWinningResultVOs"]
            .map((x) => LastDrawWinningResultVo.fromJson(x))),
    maxPanelAllowed: json["maxPanelAllowed"],
    gameSchemas: GameSchemas.fromJson(json["gameSchemas"]),
    resultConfigData: ResultConfigData.fromJson(json["resultConfigData"]),
    donation: List<Donation>.from(
        json["donation"].map((x) => Donation.fromJson(x))),
    jackpotAmount: json["jackpotAmount"],
    unitCost: json["unitCost"] != null
        ? List<UnitCost>.from(
        json["unitCost"].map((x) => UnitCost.fromJson(x)))
        : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "gameNumber": gameNumber,
    "gameName": gameName,
    "gameCode": gameCode,
    "betLimitEnabled": betLimitEnabled,
    "familyCode": familyCode,
    "lastDrawResult": lastDrawResult,
    "displayOrder": displayOrder,
    "drawFrequencyType": drawFrequencyType,
    "timeToFetchUpdatedGameInfo": timeToFetchUpdatedGameInfo,
    "numberConfig": numberConfig.toJson(),
    "betRespVOs": List<dynamic>.from(betRespVOs.map((x) => x.toJson())),
    "drawRespVOs": List<dynamic>.from(drawRespVOs.map((x) => x.toJson())),
    "nativeCurrency": nativeCurrency,
    "drawEvent": drawEvent,
    "gameStatus": gameStatus,
    "gameOrder": gameOrder,
    "consecutiveDraw": consecutiveDraw,
    "maxAdvanceDraws": maxAdvanceDraws,
    "drawPrizeMultiplier": drawPrizeMultiplier.toJson(),
    "lastDrawFreezeTime": lastDrawFreezeTime,
    "lastDrawDateTime": lastDrawDateTime,
    "lastDrawSaleStopTime": lastDrawSaleStopTime,
    "lastDrawTime": lastDrawTime,
    "ticket_expiry": ticketExpiry,
    "lastDrawWinningResultVOs":
    List<dynamic>.from(lastDrawWinningResultVOs.map((x) => x.toJson())),
    "maxPanelAllowed": maxPanelAllowed,
    "gameSchemas": gameSchemas.toJson(),
    "resultConfigData": resultConfigData.toJson(),
    "donation": List<dynamic>.from(donation.map((x) => x.toJson())),
    "jackpotAmount": jackpotAmount,
    "unitCost": unitCost != null
        ? List<dynamic>.from(unitCost!.map((x) => x.toJson()))
        : null,
  };
}

class BetRespVo {
  BetRespVo({
    required this.unitPrice,
    required this.maxBetAmtMul,
    required this.betDispName,
    required this.betCode,
    required this.betName,
    required this.betGroup,
    required this.pickTypeData,
    required this.inputCount,
    required this.winMode,
    required this.betOrder,
  });

  dynamic unitPrice;
  dynamic maxBetAmtMul;
  String betDispName;
  String betCode;
  String betName;
  dynamic betGroup;
  PickTypeData pickTypeData;
  String inputCount;
  String winMode;
  dynamic betOrder;

  factory BetRespVo.fromJson(Map<String, dynamic> json) => BetRespVo(
    unitPrice: json["unitPrice"],
    maxBetAmtMul: json["maxBetAmtMul"],
    betDispName: json["betDispName"],
    betCode: json["betCode"],
    betName: json["betName"],
    betGroup: json["betGroup"],
    pickTypeData: PickTypeData.fromJson(json["pickTypeData"]),
    inputCount: json["inputCount"],
    winMode: json["winMode"],
    betOrder: json["betOrder"],
  );

  Map<String, dynamic> toJson() => {
    "unitPrice": unitPrice,
    "maxBetAmtMul": maxBetAmtMul,
    "betDispName": betDispName,
    "betCode": betCode,
    "betName": betName,
    "betGroup": betGroup,
    "pickTypeData": pickTypeData.toJson(),
    "inputCount": inputCount,
    "winMode": winMode,
    "betOrder": betOrder,
  };
}

class PickTypeData {
  PickTypeData({
    required this.pickType,
  });

  List<PickType> pickType;

  factory PickTypeData.fromJson(Map<String, dynamic> json) => PickTypeData(
    pickType: List<PickType>.from(
        json["pickType"].map((x) => PickType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pickType": List<dynamic>.from(pickType.map((x) => x.toJson())),
  };
}

class PickType {
  PickType({
    required this.name,
    required this.code,
    required this.range,
    required this.coordinate,
    required this.description,
  });

  String name;
  String code;
  List<PickTypeRange> range;
  dynamic coordinate;
  String description;

  factory PickType.fromJson(Map<String, dynamic> json) => PickType(
    name: json["name"],
    code: json["code"],
    range: List<PickTypeRange>.from(
        json["range"].map((x) => PickTypeRange.fromJson(x))),
    coordinate: json["coordinate"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "code": code,
    "range": List<dynamic>.from(range.map((x) => x.toJson())),
    "coordinate": coordinate,
    "description": description,
  };
}

class PickTypeRange {
  PickTypeRange({
    required this.pickMode,
    required this.pickCount,
    required this.pickValue,
    required this.pickConfig,
    required this.qpAllowed,
  });

  String pickMode;
  String pickCount;
  String pickValue;
  String pickConfig;
  String qpAllowed;

  factory PickTypeRange.fromJson(Map<String, dynamic> json) => PickTypeRange(
    pickMode: json["pickMode"],
    pickCount: json["pickCount"],
    pickValue: json["pickValue"],
    pickConfig: json["pickConfig"],
    qpAllowed: json["qpAllowed"],
  );

  Map<String, dynamic> toJson() => {
    "pickMode": pickMode,
    "pickCount": pickCount,
    "pickValue": pickValue,
    "pickConfig": pickConfig,
    "qpAllowed": qpAllowed,
  };
}

class Donation {
  Donation({
    required this.image,
    required this.title,
    required this.description,
  });

  String image;
  String title;
  String description;

  factory Donation.fromJson(Map<String, dynamic> json) => Donation(
    image: json["image"],
    title: json["title"],
    description: json["description"] ?? '',
  );

  Map<String, dynamic> toJson() =>
      {"image": image, "title": title, "description": description};
}

class DrawPrizeMultiplier {
  DrawPrizeMultiplier({
    required this.createEvent,
    required this.applyOnBet,
    required this.multiplier,
  });

  dynamic createEvent;
  String applyOnBet;
  dynamic multiplier;

  factory DrawPrizeMultiplier.fromJson(Map<String, dynamic> json) =>
      DrawPrizeMultiplier(
        createEvent: json["createEvent"],
        applyOnBet: json["applyOnBet"],
        multiplier: json["multiplier"],
      );

  Map<String, dynamic> toJson() => {
    "createEvent": createEvent,
    "applyOnBet": applyOnBet,
    "multiplier": multiplier,
  };
}

class DrawRespVo {
  DrawRespVo({
    required this.drawId,
    required this.drawName,
    required this.drawDay,
    required this.drawDateTime,
    required this.drawSaleStartTime,
    required this.drawFreezeTime,
    required this.drawSaleStopTime,
    required this.drawStatus,
    required this.videoUrl,
  });

  int drawId;
  String drawName;
  String drawDay;
  DateTime drawDateTime;
  DateTime drawSaleStartTime;
  DateTime drawFreezeTime;
  DateTime drawSaleStopTime;
  String drawStatus;
  dynamic videoUrl;

  factory DrawRespVo.fromJson(Map<String, dynamic> json) => DrawRespVo(
    drawId: json["drawId"],
    drawName: json["drawName"],
    drawDay: json["drawDay"],
    drawDateTime: DateTime.parse(json["drawDateTime"]),
    drawSaleStartTime: DateTime.parse(json["drawSaleStartTime"]),
    drawFreezeTime: DateTime.parse(json["drawFreezeTime"]),
    drawSaleStopTime: DateTime.parse(json["drawSaleStopTime"]),
    drawStatus: json["drawStatus"],
    videoUrl: json["videoUrl"],
  );

  Map<String, dynamic> toJson() => {
    "drawId": drawId,
    "drawName": drawName,
    "drawDay": drawDay,
    "drawDateTime": drawDateTime.toIso8601String(),
    "drawSaleStartTime": drawSaleStartTime.toIso8601String(),
    "drawFreezeTime": drawFreezeTime.toIso8601String(),
    "drawSaleStopTime": drawSaleStopTime.toIso8601String(),
    "drawStatus": drawStatus,
    "videoUrl": videoUrl,
  };
}

class GameSchemas {
  GameSchemas({
    required this.gameDevName,
    required this.matchDetail,
  });

  String gameDevName;
  List<MatchDetail> matchDetail;

  factory GameSchemas.fromJson(Map<String, dynamic> json) => GameSchemas(
    gameDevName: json["gameDevName"],
    matchDetail: List<MatchDetail>.from(
        json["matchDetail"].map((x) => MatchDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "gameDevName": gameDevName,
    "matchDetail": List<dynamic>.from(matchDetail.map((x) => x.toJson())),
  };
}

class MatchDetail {
  MatchDetail({
    required this.slabInfo,
    required this.match,
    required this.rank,
    required this.type,
    required this.prizeAmount,
    required this.betType,
    required this.pattern,
  });

  dynamic slabInfo;
  String match;
  int rank;
  String type;
  String prizeAmount;
  String betType;
  dynamic pattern;

  factory MatchDetail.fromJson(Map<String, dynamic> json) => MatchDetail(
    slabInfo: json["slabInfo"],
    match: json["match"],
    rank: json["rank"],
    type: json["type"],
    prizeAmount: json["prizeAmount"],
    betType: json["betType"],
    pattern: json["pattern"],
  );

  Map<String, dynamic> toJson() => {
    "slabInfo": slabInfo,
    "match": match,
    "rank": rank,
    "type": type,
    "prizeAmount": prizeAmount,
    "betType": betType,
    "pattern": pattern,
  };
}

class LastDrawWinningResultVo {
  LastDrawWinningResultVo({
    required this.lastDrawDateTime,
    required this.winningNumber,
    required this.winningMultiplierInfo,
    required this.runTimeFlagInfo,
    required this.sideBetMatchInfo,
    required this.drawId,
    required this.currentDrawStatus,
  });

  DateTime lastDrawDateTime;
  String winningNumber;
  WinningMultiplierInfo winningMultiplierInfo;
  List<dynamic> runTimeFlagInfo;
  List<dynamic> sideBetMatchInfo;
  int drawId;
  dynamic currentDrawStatus;

  factory LastDrawWinningResultVo.fromJson(Map<String, dynamic> json) =>
      LastDrawWinningResultVo(
        lastDrawDateTime: DateTime.parse(json["lastDrawDateTime"]),
        winningNumber: json["winningNumber"],
        winningMultiplierInfo:
        WinningMultiplierInfo.fromJson(json["winningMultiplierInfo"]),
        runTimeFlagInfo:
        List<dynamic>.from(json["runTimeFlagInfo"].map((x) => x)),
        sideBetMatchInfo:
        List<dynamic>.from(json["sideBetMatchInfo"].map((x) => x)),
        drawId: json["drawId"],
        currentDrawStatus: json["currentDrawStatus"],
      );

  Map<String, dynamic> toJson() => {
    "lastDrawDateTime": lastDrawDateTime.toIso8601String(),
    "winningNumber": winningNumber,
    "winningMultiplierInfo": winningMultiplierInfo.toJson(),
    "runTimeFlagInfo": List<dynamic>.from(runTimeFlagInfo.map((x) => x)),
    "sideBetMatchInfo": List<dynamic>.from(sideBetMatchInfo.map((x) => x)),
    "drawId": drawId,
    "currentDrawStatus": currentDrawStatus,
  };
}

class WinningMultiplierInfo {
  WinningMultiplierInfo({
    required this.multiplierCode,
    required this.value,
  });

  dynamic multiplierCode;
  dynamic value;

  factory WinningMultiplierInfo.fromJson(Map<String, dynamic> json) =>
      WinningMultiplierInfo(
        multiplierCode: json["multiplierCode"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
    "multiplierCode": multiplierCode,
    "value": value,
  };
}

class NumberConfig {
  NumberConfig({
    required this.range,
  });

  List<NumberConfigRange> range;

  factory NumberConfig.fromJson(Map<String, dynamic> json) => NumberConfig(
    range: List<NumberConfigRange>.from(
        json["range"].map((x) => NumberConfigRange.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "range": List<dynamic>.from(range.map((x) => x.toJson())),
  };
}

class NumberConfigRange {
  NumberConfigRange({
    required this.ball,
  });

  List<Ball> ball;

  factory NumberConfigRange.fromJson(Map<String, dynamic> json) =>
      NumberConfigRange(
        ball: List<Ball>.from(json["ball"].map((x) => Ball.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "ball": List<dynamic>.from(ball.map((x) => x.toJson())),
  };
}

class Ball {
  Ball({
    required this.color,
    required this.label,
    required this.number,
  });

  String color;
  String label;
  String number;

  factory Ball.fromJson(Map<String, dynamic> json) => Ball(
    color: json["color"],
    label: json["label"],
    number: json["number"],
  );

  Map<String, dynamic> toJson() => {
    "color": color,
    "label": label,
    "number": number,
  };
}

class ResultConfigData {
  ResultConfigData({
    required this.type,
    required this.balls,
    required this.ballsPerCall,
    required this.interval,
    required this.duplicateAllowed,
  });

  String type;
  String balls;
  int ballsPerCall;
  int interval;
  bool duplicateAllowed;

  factory ResultConfigData.fromJson(Map<String, dynamic> json) =>
      ResultConfigData(
        type: json["type"],
        balls: json["balls"],
        ballsPerCall: json["ballsPerCall"],
        interval: json["interval"],
        duplicateAllowed: json["duplicateAllowed"],
      );

  Map<String, dynamic> toJson() => {
    "type": type,
    "balls": balls,
    "ballsPerCall": ballsPerCall,
    "interval": interval,
    "duplicateAllowed": duplicateAllowed,
  };
}

class UnitCost {
  UnitCost({
    this.currency,
    this.price,
  });

  String? currency;
  dynamic price;

  factory UnitCost.fromJson(Map<String, dynamic> json) => UnitCost(
    currency: json["currency"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "currency": currency,
    "price": price,
  };
}
