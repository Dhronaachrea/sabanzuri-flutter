class DrawGameResponse {
  DrawGameResponse({
    required this.success,
    required this.data,
  });

  final bool? success;
  final Data? data;

  factory DrawGameResponse.fromJson(Map<String, dynamic> json){
    return DrawGameResponse(
      success: json["success"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.responseCode,
    required this.responseMessage,
    required this.responseData,
  });

  final int? responseCode;
  final String? responseMessage;
  final ResponseData? responseData;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      responseCode: json["responseCode"],
      responseMessage: json["responseMessage"],
      responseData: json["responseData"] == null ? null : ResponseData.fromJson(json["responseData"]),
    );
  }

}

class ResponseData {
  ResponseData({
    required this.gameRespVOs,
    required this.currentDate,
    required this.config,
  });

  final List<GameRespVo> gameRespVOs;
  final DateTime? currentDate;
  final Config? config;

  factory ResponseData.fromJson(Map<String, dynamic> json){
    return ResponseData(
      gameRespVOs: json["gameRespVOs"] == null ? [] : List<GameRespVo>.from(json["gameRespVOs"]!.map((x) => GameRespVo.fromJson(x))),
      currentDate: json["currentDate"] == null ? null : DateTime.parse(json["currentDate"]),
      config: json["config"] == null ? null : Config.fromJson(json["config"]),
    );
  }

}

class Config {
  Config({
    required this.superKeno,
    required this.fiveByNinety,
    required this.twelveByTwentyFour,
  });

  final FiveByNinety? superKeno;
  final FiveByNinety? fiveByNinety;
  final FiveByNinety? twelveByTwentyFour;

  factory Config.fromJson(Map<String, dynamic> json){
    return Config(
      superKeno: json["SuperKeno"] == null ? null : FiveByNinety.fromJson(json["SuperKeno"]),
      fiveByNinety: json["FiveByNinety"] == null ? null : FiveByNinety.fromJson(json["FiveByNinety"]),
      twelveByTwentyFour: json["TwelveByTwentyFour"] == null ? null : FiveByNinety.fromJson(json["TwelveByTwentyFour"]),
    );
  }

}

class FiveByNinety {
  FiveByNinety({
    required this.lineType,
    required this.screenType,
    required this.showAddToCart,
    required this.betTypeSelectorPosition,
    required this.timerPosition,
    required this.showLastResult,
    required this.showPickTable,
  });

  final String? lineType;
  final String? screenType;
  final bool? showAddToCart;
  final String? betTypeSelectorPosition;
  final String? timerPosition;
  final bool? showLastResult;
  final bool? showPickTable;

  factory FiveByNinety.fromJson(Map<String, dynamic> json){
    return FiveByNinety(
      lineType: json["LINE_TYPE"],
      screenType: json["SCREEN_TYPE"],
      showAddToCart: json["SHOW_ADD_TO_CART"],
      betTypeSelectorPosition: json["BET_TYPE_SELECTOR_POSITION"],
      timerPosition: json["TIMER_POSITION"],
      showLastResult: json["SHOW_LAST_RESULT"],
      showPickTable: json["SHOW_PICK_TABLE"],
    );
  }

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
    required this.betRespVOs,
    required this.drawRespVOs,
    required this.drawEvent,
    required this.gameStatus,
    required this.gameOrder,
    required this.consecutiveDraw,
    required this.maxAdvanceDraws,
    required this.lastDrawFreezeTime,
    required this.lastDrawDateTime,
    required this.lastDrawSaleStopTime,
    required this.lastDrawTime,
    required this.ticketExpiry,
    required this.lastDrawWinningResultVOs,
    required this.maxPanelAllowed,
    required this.resultConfigData,
    required this.jackpotAmount,
    required this.unitCost,
  });

  final int? id;
  final int? gameNumber;
  final String? gameName;
  final String? gameCode;
  final String? betLimitEnabled;
  final String? familyCode;
  final String? lastDrawResult;
  final String? displayOrder;
  final String? drawFrequencyType;
  final DateTime? timeToFetchUpdatedGameInfo;
  final List<BetRespVo> betRespVOs;
  final List<DrawRespVo> drawRespVOs;
  final String? drawEvent;
  final String? gameStatus;
  final String? gameOrder;
  final String? consecutiveDraw;
  final int? maxAdvanceDraws;
  final String? lastDrawFreezeTime;
  final String? lastDrawDateTime;
  final String? lastDrawSaleStopTime;
  final String? lastDrawTime;
  final int? ticketExpiry;
  final List<dynamic> lastDrawWinningResultVOs;
  final int? maxPanelAllowed;
  final ResultConfigData? resultConfigData;
  final int? jackpotAmount;
  final List<UnitCost> unitCost;

  factory GameRespVo.fromJson(Map<String, dynamic> json){
    return GameRespVo(
      id: json["id"],
      gameNumber: json["gameNumber"],
      gameName: json["gameName"],
      gameCode: json["gameCode"],
      betLimitEnabled: json["betLimitEnabled"],
      familyCode: json["familyCode"],
      lastDrawResult: json["lastDrawResult"],
      displayOrder: json["displayOrder"],
      drawFrequencyType: json["drawFrequencyType"],
      timeToFetchUpdatedGameInfo: json["timeToFetchUpdatedGameInfo"] == null ? null : DateTime.parse(json["timeToFetchUpdatedGameInfo"]),
      betRespVOs: json["betRespVOs"] == null ? [] : List<BetRespVo>.from(json["betRespVOs"]!.map((x) => BetRespVo.fromJson(x))),
      drawRespVOs: json["drawRespVOs"] == null ? [] : List<DrawRespVo>.from(json["drawRespVOs"]!.map((x) => DrawRespVo.fromJson(x))),
      drawEvent: json["drawEvent"],
      gameStatus: json["gameStatus"],
      gameOrder: json["gameOrder"],
      consecutiveDraw: json["consecutiveDraw"],
      maxAdvanceDraws: json["maxAdvanceDraws"],
      lastDrawFreezeTime: json["lastDrawFreezeTime"],
      lastDrawDateTime: json["lastDrawDateTime"],
      lastDrawSaleStopTime: json["lastDrawSaleStopTime"],
      lastDrawTime: json["lastDrawTime"],
      ticketExpiry: json["ticket_expiry"],
      lastDrawWinningResultVOs: json["lastDrawWinningResultVOs"] == null ? [] : List<dynamic>.from(json["lastDrawWinningResultVOs"]!.map((x) => x)),
      maxPanelAllowed: json["maxPanelAllowed"],
      resultConfigData: json["resultConfigData"] == null ? null : ResultConfigData.fromJson(json["resultConfigData"]),
      jackpotAmount: json["jackpotAmount"],
      unitCost: json["unitCost"] == null ? [] : List<UnitCost>.from(json["unitCost"]!.map((x) => UnitCost.fromJson(x))),
    );
  }

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

  final int? unitPrice;
  final int? maxBetAmtMul;
  final String? betDispName;
  final String? betCode;
  final String? betName;
  final String? betGroup;
  final PickTypeData? pickTypeData;
  final String? inputCount;
  final String? winMode;
  final int? betOrder;

  factory BetRespVo.fromJson(Map<String, dynamic> json){
    return BetRespVo(
      unitPrice: json["unitPrice"],
      maxBetAmtMul: json["maxBetAmtMul"],
      betDispName: json["betDispName"],
      betCode: json["betCode"],
      betName: json["betName"],
      betGroup: json["betGroup"],
      pickTypeData: json["pickTypeData"] == null ? null : PickTypeData.fromJson(json["pickTypeData"]),
      inputCount: json["inputCount"],
      winMode: json["winMode"],
      betOrder: json["betOrder"],
    );
  }

}

class PickTypeData {
  PickTypeData({
    required this.pickType,
  });

  final List<PickType> pickType;

  factory PickTypeData.fromJson(Map<String, dynamic> json){
    return PickTypeData(
      pickType: json["pickType"] == null ? [] : List<PickType>.from(json["pickType"]!.map((x) => PickType.fromJson(x))),
    );
  }

}

class PickType {
  PickType({
    required this.name,
    required this.code,
    required this.range,
    required this.coordinate,
    required this.description,
  });

  final String? name;
  final String? code;
  final List<Range> range;
  final String? coordinate;
  final String? description;

  factory PickType.fromJson(Map<String, dynamic> json){
    return PickType(
      name: json["name"],
      code: json["code"],
      range: json["range"] == null ? [] : List<Range>.from(json["range"]!.map((x) => Range.fromJson(x))),
      coordinate: json["coordinate"],
      description: json["description"],
    );
  }

}

class Range {
  Range({
    required this.pickMode,
    required this.pickCount,
    required this.pickValue,
    required this.pickConfig,
    required this.qpAllowed,
  });

  final String? pickMode;
  final String? pickCount;
  final String? pickValue;
  final String? pickConfig;
  final String? qpAllowed;

  factory Range.fromJson(Map<String, dynamic> json){
    return Range(
      pickMode: json["pickMode"],
      pickCount: json["pickCount"],
      pickValue: json["pickValue"],
      pickConfig: json["pickConfig"],
      qpAllowed: json["qpAllowed"],
    );
  }

}

class DrawRespVo {
  DrawRespVo({
    required this.drawId,
    required this.drawDay,
    required this.drawDateTime,
    required this.drawSaleStartTime,
    required this.drawFreezeTime,
    required this.drawSaleStopTime,
    required this.drawStatus,
    required this.drawNo,
    required this.drawType,
    required this.ticketUploaded,
    required this.gameCode,
  });

  final int? drawId;
  final String? drawDay;
  final DateTime? drawDateTime;
  final DateTime? drawSaleStartTime;
  final DateTime? drawFreezeTime;
  final DateTime? drawSaleStopTime;
  final String? drawStatus;
  final int? drawNo;
  final dynamic drawType;
  final bool? ticketUploaded;
  final String? gameCode;

  factory DrawRespVo.fromJson(Map<String, dynamic> json){
    return DrawRespVo(
      drawId: json["drawId"],
      drawDay: json["drawDay"],
      drawDateTime: json["drawDateTime"] == null ? null : DateTime.parse(json["drawDateTime"]),
      drawSaleStartTime: json["drawSaleStartTime"] == null ? null : DateTime.parse(json["drawSaleStartTime"]),
      drawFreezeTime: json["drawFreezeTime"] == null ? null : DateTime.parse(json["drawFreezeTime"]),
      drawSaleStopTime: json["drawSaleStopTime"] == null ? null : DateTime.parse(json["drawSaleStopTime"]),
      drawStatus: json["drawStatus"],
      drawNo: json["drawNo"],
      drawType: json["drawType"],
      ticketUploaded: json["ticketUploaded"],
      gameCode: json["GameCode"],
    );
  }

}

class ResultConfigData {
  ResultConfigData({
    required this.type,
    required this.balls,
    required this.ballsPerCall,
    required this.interval,
    required this.duplicateAllowed,
  });

  final String? type;
  final String? balls;
  final int? ballsPerCall;
  final int? interval;
  final bool? duplicateAllowed;

  factory ResultConfigData.fromJson(Map<String, dynamic> json){
    return ResultConfigData(
      type: json["type"],
      balls: json["balls"],
      ballsPerCall: json["ballsPerCall"],
      interval: json["interval"],
      duplicateAllowed: json["duplicateAllowed"],
    );
  }

}

class UnitCost {
  UnitCost({
    required this.currency,
    required this.price,
  });

  final String? currency;
  final int? price;

  factory UnitCost.fromJson(Map<String, dynamic> json){
    return UnitCost(
      currency: json["currency"],
      price: json["price"],
    );
  }

}
