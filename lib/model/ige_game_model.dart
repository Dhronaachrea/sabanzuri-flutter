import 'dart:convert';

IgeGameModel igeGameModelFromJson(String str) =>
    IgeGameModel.fromJson(json.decode(str));

String igeGameModelToJson(IgeGameModel data) => json.encode(data.toJson());

class IgeGameModel {
  IgeGameModel({
    required this.success,
    this.data,
  });

  bool success;
  Data? data;

  factory IgeGameModel.fromJson(Map<String, dynamic> json) => IgeGameModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.ige,
    this.ipAddress,
  });

  Ige? ige;
  String? ipAddress;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        ige: Ige.fromJson(json["ige"]),
        ipAddress: json["ipAddress"],
      );

  Map<String, dynamic> toJson() => {
        "ige": ige?.toJson(),
        "ipAddress": ipAddress,
      };
}

class Ige {
  Ige({
    this.engines,
  });

  Engines? engines;

  factory Ige.fromJson(Map<String, dynamic> json) => Ige(
        engines: Engines.fromJson(json["engines"]),
      );

  Map<String, dynamic> toJson() => {
        "engines": engines?.toJson(),
      };
}

class Engines {
  Engines({
    this.kenya,
  });

  Kenya? kenya;

  factory Engines.fromJson(Map<String, dynamic> json) => Engines(
        kenya: Kenya.fromJson(json["KENYA"]),
      );

  Map<String, dynamic> toJson() => {
        "KENYA": kenya?.toJson(),
      };
}

class Kenya {
  Kenya({
    this.games,
    this.params,
  });

  List<Game>? games;
  Params? params;

  factory Kenya.fromJson(Map<String, dynamic> json) => Kenya(
        games: List<Game>.from(json["games"].map((x) => Game.fromJson(x))),
        params: Params.fromJson(json["params"]),
      );

  Map<String, dynamic> toJson() => {
        "games": games != null
            ? List<dynamic>.from(games!.map((x) => x.toJson()))
            : null,
        "params": params?.toJson(),
      };
}

class Game {
  Game({
    this.loaderImage,
    this.prizeSchemes,
    this.orderId,
    this.imagePath,
    this.windowHeight,
    this.isHtml5,
    this.isKeyboard,
    this.gameCategory,
    this.gameName,
    this.gameNumber,
    this.gameVersion,
    this.gameDescription,
    this.currencyCode,
    this.windowWidth,
    this.isFlash,
    this.status,
    this.isImageGeneration,
    this.isTablet,
    this.gameWinUpto,
    this.jackpotStatus,
    this.bonusMultiplier,
    this.setId,
    this.setName,
    this.betList,
    this.productInfo,
  });

  Map<String, String>? loaderImage;
  Map<String, int>? prizeSchemes;
  int? orderId;
  String? imagePath;
  int? windowHeight;
  String? isHtml5;
  String? isKeyboard;
  String? gameCategory;
  String? gameName;
  int? gameNumber;
  String? gameVersion;
  String? gameDescription;
  String? currencyCode;
  int? windowWidth;
  String? isFlash;
  String? status;
  dynamic isImageGeneration;
  dynamic isTablet;
  dynamic gameWinUpto;
  String? jackpotStatus;
  String? bonusMultiplier;
  int? setId;
  String? setName;
  List<int>? betList;
  ProductInfo? productInfo;

  factory Game.fromJson(Map<String, dynamic> json) => Game(
        loaderImage: Map.from(json["loaderImage"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        prizeSchemes: Map.from(json["prizeSchemes"])
            .map((k, v) => MapEntry<String, int>(k, v)),
        orderId: json["orderId"],
        imagePath: json["imagePath"],
        windowHeight: json["windowHeight"],
        isHtml5: json["isHTML5"],
        isKeyboard: json["isKeyboard"],
        gameCategory: json["gameCategory"],
        gameName: json["gameName"],
        gameNumber: json["gameNumber"],
        gameVersion: json["gameVersion"],
        gameDescription: json["gameDescription"],
        currencyCode: json["currencyCode"],
        windowWidth: json["windowWidth"],
        isFlash: json["isFlash"],
        status: json["status"],
        isImageGeneration: json["isImageGeneration"],
        isTablet: json["isTablet"],
        gameWinUpto: json["gameWinUpto"],
        jackpotStatus: json["jackpotStatus"],
        bonusMultiplier: json["bonusMultiplier"],
        setId: json["setId"],
        setName: json["setName"],
        betList: List<int>.from(json["betList"].map((x) => x)),
        productInfo: ProductInfo.fromJson(json["productInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "loaderImage": loaderImage != null
            ? Map.from(loaderImage!)
                .map((k, v) => MapEntry<String, dynamic>(k, v))
            : null,
        "prizeSchemes": prizeSchemes != null
            ? Map.from(prizeSchemes!)
                .map((k, v) => MapEntry<String, dynamic>(k, v))
            : null,
        "orderId": orderId,
        "imagePath": imagePath,
        "windowHeight": windowHeight,
        "isHTML5": isHtml5,
        "isKeyboard": isKeyboard,
        "gameCategory": gameCategory,
        "gameName": gameName,
        "gameNumber": gameNumber,
        "gameVersion": gameVersion,
        "gameDescription": gameDescription,
        "currencyCode": currencyCode,
        "windowWidth": windowWidth,
        "isFlash": isFlash,
        "status": status,
        "isImageGeneration": isImageGeneration,
        "isTablet": isTablet,
        "gameWinUpto": gameWinUpto,
        "jackpotStatus": jackpotStatus,
        "bonusMultiplier": bonusMultiplier,
        "setId": setId,
        "setName": setName,
        "betList":
            betList != null ? List<dynamic>.from(betList!.map((x) => x)) : null,
        "productInfo": productInfo?.toJson(),
      };
}

class ProductInfo {
  ProductInfo({
    this.donation,
  });

  List<Donation>? donation;

  factory ProductInfo.fromJson(Map<String, dynamic> json) => ProductInfo(
        donation: json["donation"] == null
            ? null
            : List<Donation>.from(
                json["donation"].map((x) => Donation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "donation": donation == null
            ? null
            : List<dynamic>.from(donation!.map((x) => x.toJson())),
      };
}

class Donation {
  Donation({
    this.image,
    this.title,
  });

  String? image;
  String? title;

  factory Donation.fromJson(Map<String, dynamic> json) => Donation(
        image: json["image"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "title": title,
      };
}

class Params {
  Params({
    this.root,
    this.repo,
    this.merchantCode,
    this.merchantKey,
    this.secureKey,
    this.domainName,
    this.lang,
    required this.currencyCode,
    this.vendorType,
  });

  String? root;
  String? repo;
  String? merchantCode;
  int? merchantKey;
  String? secureKey;
  String? domainName;
  String? lang;
  List<dynamic> currencyCode;
  String? vendorType;

  factory Params.fromJson(Map<String, dynamic> json) => Params(
        root: json["root"],
        repo: json["repo"],
        merchantCode: json["merchantCode"],
        merchantKey: json["merchantKey"],
        secureKey: json["secureKey"],
        domainName: json["domainName"],
        lang: json["lang"],
        currencyCode: json["currencyCode"],
        vendorType: json["vendorType"],
      );

  Map<String, dynamic> toJson() => {
        "root": root,
        "repo": repo,
        "merchantCode": merchantCode,
        "merchantKey": merchantKey,
        "secureKey": secureKey,
        "domainName": domainName,
        "lang": lang,
        "currencyCode": currencyCode,
        "vendorType": vendorType,
      };
}
