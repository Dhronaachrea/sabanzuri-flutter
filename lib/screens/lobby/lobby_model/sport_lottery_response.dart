class SportLotteryResponse {
  int? responseCode;
  String? responseMessage;
  List<ResponseData>? responseData;

  SportLotteryResponse(
      {this.responseCode, this.responseMessage, this.responseData});

  SportLotteryResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];
    if (json['responseData'] != null) {
      responseData = <ResponseData>[];
      json['responseData'].forEach((v) {
        responseData!.add(new ResponseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseCode'] = this.responseCode;
    data['responseMessage'] = this.responseMessage;
    if (this.responseData != null) {
      data['responseData'] = this.responseData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResponseData {
  int? id;
  int? sportId;
  int? feedEnable;
  int? hasAddOnDraw;
  String? gameType;
  Null? parentGameId;
  String? gameEventType;
  String? gameCode;
  int? rolloverNumber;
  String? gameName;
  int? merchantGameId;
  String? sportCode;
  int? noOfFixtures;
  int? noOfSelections;
  int? minNoOfParticipantsInOneEvent;
  int? maxNoOfParticipantsInOneEvent;
  String? unitTicketPriceJson;
  double? maxTicketMultiple;
  String? maxSaleAmountSystemJson;
  double? minimumPoolAmountSystem;
  double? prizePayoutPercentage;
  Null? reservePoolPercentage;
  double? minDisplayJackpotAmount;
  int? nextDrawNo;
  String? status;
  bool? isMultiPlayAllowed;
  bool? multiPlayDefault;
  int? resultSubmissionLevel;
  bool? winningOnCancelResult;
  String? configs;
  List<DrawData>? drawData;
  String? rollingRuleType;
  String? fixtureType;
  String? createdAt;
  String? updatedAt;
  String? currentTime;

  ResponseData(
      {this.id,
        this.sportId,
        this.feedEnable,
        this.hasAddOnDraw,
        this.gameType,
        this.parentGameId,
        this.gameEventType,
        this.gameCode,
        this.rolloverNumber,
        this.gameName,
        this.merchantGameId,
        this.sportCode,
        this.noOfFixtures,
        this.noOfSelections,
        this.minNoOfParticipantsInOneEvent,
        this.maxNoOfParticipantsInOneEvent,
        this.unitTicketPriceJson,
        this.maxTicketMultiple,
        this.maxSaleAmountSystemJson,
        this.minimumPoolAmountSystem,
        this.prizePayoutPercentage,
        this.reservePoolPercentage,
        this.minDisplayJackpotAmount,
        this.nextDrawNo,
        this.status,
        this.isMultiPlayAllowed,
        this.multiPlayDefault,
        this.resultSubmissionLevel,
        this.winningOnCancelResult,
        this.configs,
        this.drawData,
        this.rollingRuleType,
        this.fixtureType,
        this.createdAt,
        this.updatedAt,
        this.currentTime});

  ResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sportId = json['sportId'];
    feedEnable = json['feedEnable'];
    hasAddOnDraw = json['hasAddOnDraw'];
    gameType = json['gameType'];
    parentGameId = json['parentGameId'];
    gameEventType = json['gameEventType'];
    gameCode = json['gameCode'];
    rolloverNumber = json['rolloverNumber'];
    gameName = json['gameName'];
    merchantGameId = json['merchantGameId'];
    sportCode = json['sportCode'];
    noOfFixtures = json['noOfFixtures'];
    noOfSelections = json['noOfSelections'];
    minNoOfParticipantsInOneEvent = json['minNoOfParticipantsInOneEvent'];
    maxNoOfParticipantsInOneEvent = json['maxNoOfParticipantsInOneEvent'];
    unitTicketPriceJson = json['unitTicketPriceJson'];
    maxTicketMultiple = json['maxTicketMultiple'];
    maxSaleAmountSystemJson = json['maxSaleAmountSystemJson'];
    minimumPoolAmountSystem = json['minimumPoolAmountSystem'];
    prizePayoutPercentage = json['prizePayoutPercentage'];
    reservePoolPercentage = json['reservePoolPercentage'];
    minDisplayJackpotAmount = json['minDisplayJackpotAmount'];
    nextDrawNo = json['nextDrawNo'];
    status = json['status'];
    isMultiPlayAllowed = json['isMultiPlayAllowed'];
    multiPlayDefault = json['multiPlayDefault'];
    resultSubmissionLevel = json['resultSubmissionLevel'];
    winningOnCancelResult = json['winningOnCancelResult'];
    configs = json['configs'];
    if (json['drawData'] != null) {
      drawData = <DrawData>[];
      json['drawData'].forEach((v) {
        drawData!.add(new DrawData.fromJson(v));
      });
    }
    rollingRuleType = json['rollingRuleType'];
    fixtureType = json['fixtureType'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    currentTime = json['currentTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sportId'] = this.sportId;
    data['feedEnable'] = this.feedEnable;
    data['hasAddOnDraw'] = this.hasAddOnDraw;
    data['gameType'] = this.gameType;
    data['parentGameId'] = this.parentGameId;
    data['gameEventType'] = this.gameEventType;
    data['gameCode'] = this.gameCode;
    data['rolloverNumber'] = this.rolloverNumber;
    data['gameName'] = this.gameName;
    data['merchantGameId'] = this.merchantGameId;
    data['sportCode'] = this.sportCode;
    data['noOfFixtures'] = this.noOfFixtures;
    data['noOfSelections'] = this.noOfSelections;
    data['minNoOfParticipantsInOneEvent'] = this.minNoOfParticipantsInOneEvent;
    data['maxNoOfParticipantsInOneEvent'] = this.maxNoOfParticipantsInOneEvent;
    data['unitTicketPriceJson'] = this.unitTicketPriceJson;
    data['maxTicketMultiple'] = this.maxTicketMultiple;
    data['maxSaleAmountSystemJson'] = this.maxSaleAmountSystemJson;
    data['minimumPoolAmountSystem'] = this.minimumPoolAmountSystem;
    data['prizePayoutPercentage'] = this.prizePayoutPercentage;
    data['reservePoolPercentage'] = this.reservePoolPercentage;
    data['minDisplayJackpotAmount'] = this.minDisplayJackpotAmount;
    data['nextDrawNo'] = this.nextDrawNo;
    data['status'] = this.status;
    data['isMultiPlayAllowed'] = this.isMultiPlayAllowed;
    data['multiPlayDefault'] = this.multiPlayDefault;
    data['resultSubmissionLevel'] = this.resultSubmissionLevel;
    data['winningOnCancelResult'] = this.winningOnCancelResult;
    data['configs'] = this.configs;
    if (this.drawData != null) {
      data['drawData'] = this.drawData!.map((v) => v.toJson()).toList();
    }
    data['rollingRuleType'] = this.rollingRuleType;
    data['fixtureType'] = this.fixtureType;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['currentTime'] = this.currentTime;
    return data;
  }
}

class DrawData {
  int? id;
  String? provider;
  String? providerUid;
  String? drawType;
  int? drawNo;
  String? drawName;
  String? saleStartTime;
  String? drawFreezeTime;
  String? drawDateTime;
  String? drawStatus;
  String? resultStatus;
  int? maxNoOfParticipantInOneEvent;
  String? currency;
  double? betAmountMultiple;
  bool? isMultiPlayAllowed;
  double? minimumPoolAmount;
  double? distributableAmtTillNow;
  double? totalSaleTillNow;
  double? unitTicketPrice;
  UnitTicketPriceJson? unitTicketPriceJson;
  double? maxTicketPrice;
  String? sportCode;
  String? gameName;
  double? jackpotAmount;
  String? gameCode;
  int? merchantGameId;
  String? createdAt;
  String? updatedAt;
  String? currentTime;
  List<Markets>? markets;
  AddOnDrawData? addOnDrawData;

  DrawData(
      {this.id,
        this.provider,
        this.providerUid,
        this.drawType,
        this.drawNo,
        this.drawName,
        this.saleStartTime,
        this.drawFreezeTime,
        this.drawDateTime,
        this.drawStatus,
        this.resultStatus,
        this.maxNoOfParticipantInOneEvent,
        this.currency,
        this.betAmountMultiple,
        this.isMultiPlayAllowed,
        this.minimumPoolAmount,
        this.distributableAmtTillNow,
        this.totalSaleTillNow,
        this.unitTicketPrice,
        this.unitTicketPriceJson,
        this.maxTicketPrice,
        this.sportCode,
        this.gameName,
        this.jackpotAmount,
        this.gameCode,
        this.merchantGameId,
        this.createdAt,
        this.updatedAt,
        this.currentTime,
        this.markets,
        this.addOnDrawData});

  DrawData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    provider = json['provider'];
    providerUid = json['providerUid'];
    drawType = json['drawType'];
    drawNo = json['drawNo'];
    drawName = json['drawName'];
    saleStartTime = json['saleStartTime'];
    drawFreezeTime = json['drawFreezeTime'];
    drawDateTime = json['drawDateTime'];
    drawStatus = json['drawStatus'];
    resultStatus = json['resultStatus'];
    maxNoOfParticipantInOneEvent = json['maxNoOfParticipantInOneEvent'];
    currency = json['currency'];
    betAmountMultiple = json['betAmountMultiple'];
    isMultiPlayAllowed = json['isMultiPlayAllowed'];
    minimumPoolAmount = json['minimumPoolAmount'];
    distributableAmtTillNow = json['distributableAmtTillNow'];
    totalSaleTillNow = json['totalSaleTillNow'];
    unitTicketPrice = json['unitTicketPrice'];
    unitTicketPriceJson = json['unitTicketPriceJson'] != null
        ? new UnitTicketPriceJson.fromJson(json['unitTicketPriceJson'])
        : null;
    maxTicketPrice = json['maxTicketPrice'];
    sportCode = json['sportCode'];
    gameName = json['gameName'];
    jackpotAmount = json['jackpotAmount'];
    gameCode = json['gameCode'];
    merchantGameId = json['merchantGameId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    currentTime = json['currentTime'];
    if (json['markets'] != null) {
      markets = <Markets>[];
      json['markets'].forEach((v) {
        markets!.add(new Markets.fromJson(v));
      });
    }
    addOnDrawData = json['addOnDrawData'] != null
        ? new AddOnDrawData.fromJson(json['addOnDrawData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['provider'] = this.provider;
    data['providerUid'] = this.providerUid;
    data['drawType'] = this.drawType;
    data['drawNo'] = this.drawNo;
    data['drawName'] = this.drawName;
    data['saleStartTime'] = this.saleStartTime;
    data['drawFreezeTime'] = this.drawFreezeTime;
    data['drawDateTime'] = this.drawDateTime;
    data['drawStatus'] = this.drawStatus;
    data['resultStatus'] = this.resultStatus;
    data['maxNoOfParticipantInOneEvent'] = this.maxNoOfParticipantInOneEvent;
    data['currency'] = this.currency;
    data['betAmountMultiple'] = this.betAmountMultiple;
    data['isMultiPlayAllowed'] = this.isMultiPlayAllowed;
    data['minimumPoolAmount'] = this.minimumPoolAmount;
    data['distributableAmtTillNow'] = this.distributableAmtTillNow;
    data['totalSaleTillNow'] = this.totalSaleTillNow;
    data['unitTicketPrice'] = this.unitTicketPrice;
    if (this.unitTicketPriceJson != null) {
      data['unitTicketPriceJson'] = this.unitTicketPriceJson!.toJson();
    }
    data['maxTicketPrice'] = this.maxTicketPrice;
    data['sportCode'] = this.sportCode;
    data['gameName'] = this.gameName;
    data['jackpotAmount'] = this.jackpotAmount;
    data['gameCode'] = this.gameCode;
    data['merchantGameId'] = this.merchantGameId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['currentTime'] = this.currentTime;
    if (this.markets != null) {
      data['markets'] = this.markets!.map((v) => v.toJson()).toList();
    }
    if (this.addOnDrawData != null) {
      data['addOnDrawData'] = this.addOnDrawData!.toJson();
    }
    return data;
  }
}

class UnitTicketPriceJson {
  double? xAF;
  double? tHB;
  double? mMK;
  int? uSD;
  dynamic eUR;
  int? bTC;
  int? dOGE;
  int? tRX;
  int? lINK;

  UnitTicketPriceJson(
      {this.xAF,
        this.tHB,
        this.mMK,
        this.uSD,
        this.eUR,
        this.bTC,
        this.dOGE,
        this.tRX,
        this.lINK});

  UnitTicketPriceJson.fromJson(Map<String, dynamic> json) {
    xAF = json['XAF'];
    tHB = json['THB'];
    mMK = json['MMK'];
    uSD = json['USD'];
    eUR = json['EUR'];
    bTC = json['BTC'];
    dOGE = json['DOGE'];
    tRX = json['TRX'];
    lINK = json['LINK'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['XAF'] = this.xAF;
    data['THB'] = this.tHB;
    data['MMK'] = this.mMK;
    data['USD'] = this.uSD;
    data['EUR'] = this.eUR;
    data['BTC'] = this.bTC;
    data['DOGE'] = this.dOGE;
    data['TRX'] = this.tRX;
    data['LINK'] = this.lINK;
    return data;
  }
}

class Markets {
  int? marketId;
  String? marketCode;
  String? marketName;
  int? level;
  List<EventDetail>? eventDetail;

  Markets(
      {this.marketId,
        this.marketCode,
        this.marketName,
        this.level,
        this.eventDetail});

  Markets.fromJson(Map<String, dynamic> json) {
    marketId = json['marketId'];
    marketCode = json['marketCode'];
    marketName = json['marketName'];
    level = json['level'];
    if (json['eventDetail'] != null) {
      eventDetail = <EventDetail>[];
      json['eventDetail'].forEach((v) {
        eventDetail!.add(new EventDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['marketId'] = this.marketId;
    data['marketCode'] = this.marketCode;
    data['marketName'] = this.marketName;
    data['level'] = this.level;
    if (this.eventDetail != null) {
      data['eventDetail'] = this.eventDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EventDetail {
  int? id;
  String? eventType;
  String? provider;
  String? providerReferenceId;
  int? sportId;
  String? venueName;
  String? eventName;
  int? homeTeamId;
  String? homeTeamName;
  String? homeTeamAbbr;
  int? awayTeamId;
  String? awayTeamName;
  String? awayTeamAbbr;
  String? scheduledAt;
  String? startTime;
  String? endTime;
  List<OptionInfo>? optionInfo;
  bool? feedEvent;

  EventDetail(
      {this.id,
        this.eventType,
        this.provider,
        this.providerReferenceId,
        this.sportId,
        this.venueName,
        this.eventName,
        this.homeTeamId,
        this.homeTeamName,
        this.homeTeamAbbr,
        this.awayTeamId,
        this.awayTeamName,
        this.awayTeamAbbr,
        this.scheduledAt,
        this.startTime,
        this.endTime,
        this.optionInfo,
        this.feedEvent});

  EventDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventType = json['eventType'];
    provider = json['provider'];
    providerReferenceId = json['providerReferenceId'];
    sportId = json['sportId'];
    venueName = json['venueName'];
    eventName = json['eventName'];
    homeTeamId = json['homeTeamId'];
    homeTeamName = json['homeTeamName'];
    homeTeamAbbr = json['homeTeamAbbr'];
    awayTeamId = json['awayTeamId'];
    awayTeamName = json['awayTeamName'];
    awayTeamAbbr = json['awayTeamAbbr'];
    scheduledAt = json['scheduledAt'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    if (json['optionInfo'] != null) {
      optionInfo = <OptionInfo>[];
      json['optionInfo'].forEach((v) {
        optionInfo!.add(new OptionInfo.fromJson(v));
      });
    }
    feedEvent = json['feedEvent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['eventType'] = this.eventType;
    data['provider'] = this.provider;
    data['providerReferenceId'] = this.providerReferenceId;
    data['sportId'] = this.sportId;
    data['venueName'] = this.venueName;
    data['eventName'] = this.eventName;
    data['homeTeamId'] = this.homeTeamId;
    data['homeTeamName'] = this.homeTeamName;
    data['homeTeamAbbr'] = this.homeTeamAbbr;
    data['awayTeamId'] = this.awayTeamId;
    data['awayTeamName'] = this.awayTeamName;
    data['awayTeamAbbr'] = this.awayTeamAbbr;
    data['scheduledAt'] = this.scheduledAt;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    if (this.optionInfo != null) {
      data['optionInfo'] = this.optionInfo!.map((v) => v.toJson()).toList();
    }
    data['feedEvent'] = this.feedEvent;
    return data;
  }
}

class OptionInfo {
  int? id;
  int? eventMarketId;
  int? marketId;
  int? outcomeId;
  String? tpOptionCode;
  String? tpOptionName;
  int? probability;

  OptionInfo(
      {this.id,
        this.eventMarketId,
        this.marketId,
        this.outcomeId,
        this.tpOptionCode,
        this.tpOptionName,
        this.probability});

  OptionInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventMarketId = json['eventMarketId'];
    marketId = json['marketId'];
    outcomeId = json['outcomeId'];
    tpOptionCode = json['tpOptionCode'];
    tpOptionName = json['tpOptionName'];
    probability = json['probability'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['eventMarketId'] = this.eventMarketId;
    data['marketId'] = this.marketId;
    data['outcomeId'] = this.outcomeId;
    data['tpOptionCode'] = this.tpOptionCode;
    data['tpOptionName'] = this.tpOptionName;
    data['probability'] = this.probability;
    return data;
  }
}

class AddOnDrawData {
  int? id;
  String? provider;
  String? providerUid;
  String? drawType;
  int? drawNo;
  String? drawName;
  String? saleStartTime;
  String? drawFreezeTime;
  String? drawDateTime;
  String? drawStatus;
  String? resultStatus;
  int? maxNoOfParticipantInOneEvent;
  String? currency;
  double? betAmountMultiple;
  bool? isMultiPlayAllowed;
  double? minimumPoolAmount;
  double? distributableAmtTillNow;
  double? totalSaleTillNow;
  double? unitTicketPrice;
  UnitTicketPriceJson? unitTicketPriceJson;
  double? maxTicketPrice;
  String? sportCode;
  String? gameName;
  double? jackpotAmount;
  String? gameCode;
  String? createdAt;
  String? updatedAt;
  String? currentTime;
  List<Markets>? markets;

  AddOnDrawData(
      {this.id,
        this.provider,
        this.providerUid,
        this.drawType,
        this.drawNo,
        this.drawName,
        this.saleStartTime,
        this.drawFreezeTime,
        this.drawDateTime,
        this.drawStatus,
        this.resultStatus,
        this.maxNoOfParticipantInOneEvent,
        this.currency,
        this.betAmountMultiple,
        this.isMultiPlayAllowed,
        this.minimumPoolAmount,
        this.distributableAmtTillNow,
        this.totalSaleTillNow,
        this.unitTicketPrice,
        this.unitTicketPriceJson,
        this.maxTicketPrice,
        this.sportCode,
        this.gameName,
        this.jackpotAmount,
        this.gameCode,
        this.createdAt,
        this.updatedAt,
        this.currentTime,
        this.markets});

  AddOnDrawData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    provider = json['provider'];
    providerUid = json['providerUid'];
    drawType = json['drawType'];
    drawNo = json['drawNo'];
    drawName = json['drawName'];
    saleStartTime = json['saleStartTime'];
    drawFreezeTime = json['drawFreezeTime'];
    drawDateTime = json['drawDateTime'];
    drawStatus = json['drawStatus'];
    resultStatus = json['resultStatus'];
    maxNoOfParticipantInOneEvent = json['maxNoOfParticipantInOneEvent'];
    currency = json['currency'];
    betAmountMultiple = json['betAmountMultiple'];
    isMultiPlayAllowed = json['isMultiPlayAllowed'];
    minimumPoolAmount = json['minimumPoolAmount'];
    distributableAmtTillNow = json['distributableAmtTillNow'];
    totalSaleTillNow = json['totalSaleTillNow'];
    unitTicketPrice = json['unitTicketPrice'];
    unitTicketPriceJson = json['unitTicketPriceJson'] != null
        ? new UnitTicketPriceJson.fromJson(json['unitTicketPriceJson'])
        : null;
    maxTicketPrice = json['maxTicketPrice'];
    sportCode = json['sportCode'];
    gameName = json['gameName'];
    jackpotAmount = json['jackpotAmount'];
    gameCode = json['gameCode'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    currentTime = json['currentTime'];
    if (json['markets'] != null) {
      markets = <Markets>[];
      json['markets'].forEach((v) {
        markets!.add(new Markets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['provider'] = this.provider;
    data['providerUid'] = this.providerUid;
    data['drawType'] = this.drawType;
    data['drawNo'] = this.drawNo;
    data['drawName'] = this.drawName;
    data['saleStartTime'] = this.saleStartTime;
    data['drawFreezeTime'] = this.drawFreezeTime;
    data['drawDateTime'] = this.drawDateTime;
    data['drawStatus'] = this.drawStatus;
    data['resultStatus'] = this.resultStatus;
    data['maxNoOfParticipantInOneEvent'] = this.maxNoOfParticipantInOneEvent;
    data['currency'] = this.currency;
    data['betAmountMultiple'] = this.betAmountMultiple;
    data['isMultiPlayAllowed'] = this.isMultiPlayAllowed;
    data['minimumPoolAmount'] = this.minimumPoolAmount;
    data['distributableAmtTillNow'] = this.distributableAmtTillNow;
    data['totalSaleTillNow'] = this.totalSaleTillNow;
    data['unitTicketPrice'] = this.unitTicketPrice;
    if (this.unitTicketPriceJson != null) {
      data['unitTicketPriceJson'] = this.unitTicketPriceJson!.toJson();
    }
    data['maxTicketPrice'] = this.maxTicketPrice;
    data['sportCode'] = this.sportCode;
    data['gameName'] = this.gameName;
    data['jackpotAmount'] = this.jackpotAmount;
    data['gameCode'] = this.gameCode;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['currentTime'] = this.currentTime;
    if (this.markets != null) {
      data['markets'] = this.markets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
