class IgeGameResponse {
  bool? success;
  Data? data;

  IgeGameResponse({this.success, this.data});

  IgeGameResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Ige? ige;
  String? ipAddress;

  Data({this.ige, this.ipAddress});

  Data.fromJson(Map<String, dynamic> json) {
    ige = json['ige'] != null ? new Ige.fromJson(json['ige']) : null;
    ipAddress = json['ipAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ige != null) {
      data['ige'] = this.ige!.toJson();
    }
    data['ipAddress'] = this.ipAddress;
    return data;
  }
}

class Ige {
  Engines? engines;

  Ige({this.engines});

  Ige.fromJson(Map<String, dynamic> json) {
    engines =
    json['engines'] != null ? new Engines.fromJson(json['engines']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.engines != null) {
      data['engines'] = this.engines!.toJson();
    }
    return data;
  }
}

class Engines {
  NEW? nEW;

  Engines({this.nEW});

  Engines.fromJson(Map<String, dynamic> json) {
    nEW = json['NEW'] != null ? new NEW.fromJson(json['NEW']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.nEW != null) {
      data['NEW'] = this.nEW!.toJson();
    }
    return data;
  }
}

class NEW {
  List<Games>? games;
  Params? params;

  NEW({this.games, this.params});

  NEW.fromJson(Map<String, dynamic> json) {
    if (json['games'] != null) {
      games = <Games>[];
      json['games'].forEach((v) {
        games!.add(new Games.fromJson(v));
      });
    }
    params =
    json['params'] != null ? new Params.fromJson(json['params']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.games != null) {
      data['games'] = this.games!.map((v) => v.toJson()).toList();
    }
    if (this.params != null) {
      data['params'] = this.params!.toJson();
    }
    return data;
  }
}

class Games {
  LoaderImage? loaderImage;
  PrizeSchemes? prizeSchemes;
  int? orderId;
  String? imagePath;
  int? windowHeight;
  String? isHTML5;
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
  Null? isImageGeneration;
  Null? isTablet;
  Null? gameWinUpto;
  String? jackpotStatus;
  String? bonusMultiplier;
  int? setId;
  String? setName;
  List<int>? betList;
  ProductInfo? productInfo;

  Games(
      {this.loaderImage,
        this.prizeSchemes,
        this.orderId,
        this.imagePath,
        this.windowHeight,
        this.isHTML5,
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
        this.productInfo});

  Games.fromJson(Map<String, dynamic> json) {
    loaderImage = json['loaderImage'] != null
        ? new LoaderImage.fromJson(json['loaderImage'])
        : null;
    prizeSchemes = json['prizeSchemes'] != null
        ? new PrizeSchemes.fromJson(json['prizeSchemes'])
        : null;
    orderId = json['orderId'];
    imagePath = json['imagePath'];
    windowHeight = json['windowHeight'];
    isHTML5 = json['isHTML5'];
    isKeyboard = json['isKeyboard'];
    gameCategory = json['gameCategory'];
    gameName = json['gameName'];
    gameNumber = json['gameNumber'];
    gameVersion = json['gameVersion'];
    gameDescription = json['gameDescription'];
    currencyCode = json['currencyCode'];
    windowWidth = json['windowWidth'];
    isFlash = json['isFlash'];
    status = json['status'];
    isImageGeneration = json['isImageGeneration'];
    isTablet = json['isTablet'];
    gameWinUpto = json['gameWinUpto'];
    jackpotStatus = json['jackpotStatus'];
    bonusMultiplier = json['bonusMultiplier'];
    setId = json['setId'];
    setName = json['setName'];
    betList = json['betList'].cast<int>();
    productInfo = json['productInfo'] != null
        ? new ProductInfo.fromJson(json['productInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.loaderImage != null) {
      data['loaderImage'] = this.loaderImage!.toJson();
    }
    if (this.prizeSchemes != null) {
      data['prizeSchemes'] = this.prizeSchemes!.toJson();
    }
    data['orderId'] = this.orderId;
    data['imagePath'] = this.imagePath;
    data['windowHeight'] = this.windowHeight;
    data['isHTML5'] = this.isHTML5;
    data['isKeyboard'] = this.isKeyboard;
    data['gameCategory'] = this.gameCategory;
    data['gameName'] = this.gameName;
    data['gameNumber'] = this.gameNumber;
    data['gameVersion'] = this.gameVersion;
    data['gameDescription'] = this.gameDescription;
    data['currencyCode'] = this.currencyCode;
    data['windowWidth'] = this.windowWidth;
    data['isFlash'] = this.isFlash;
    data['status'] = this.status;
    data['isImageGeneration'] = this.isImageGeneration;
    data['isTablet'] = this.isTablet;
    data['gameWinUpto'] = this.gameWinUpto;
    data['jackpotStatus'] = this.jackpotStatus;
    data['bonusMultiplier'] = this.bonusMultiplier;
    data['setId'] = this.setId;
    data['setName'] = this.setName;
    data['betList'] = this.betList;
    if (this.productInfo != null) {
      data['productInfo'] = this.productInfo!.toJson();
    }
    return data;
  }
}

class LoaderImage {
  String? s960;
  String? s1777;

  LoaderImage({this.s960, this.s1777});

  LoaderImage.fromJson(Map<String, dynamic> json) {
    s960 = json['960'];
    s1777 = json['1777'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['960'] = this.s960;
    data['1777'] = this.s1777;
    return data;
  }
}

class PrizeSchemes {
  dynamic d531;
  dynamic d536;
  dynamic d461;
  dynamic d462;
  dynamic d463;
  dynamic d464;
  dynamic d465;
  dynamic d526;
  dynamic d441;
  dynamic d442;
  dynamic d443;
  dynamic d444;
  dynamic d445;
  dynamic d451;
  dynamic d452;
  dynamic d453;
  dynamic d454;
  dynamic d455;
  dynamic d902;
  dynamic d905;
  dynamic d903;
  dynamic d904;

  PrizeSchemes(
      {this.d531,
        this.d441,
        this.d442,
        this.d443,
        this.d444,
        this.d445,
        this.d536,
        this.d526,
        this.d461,
        this.d462,
        this.d463,
        this.d464,
        this.d465,
        this.d451,
        this.d452,
        this.d453,
        this.d454,
        this.d455,
        this.d905,
        this.d903,
        this.d904});

  PrizeSchemes.fromJson(Map<String, dynamic> json) {
    d531 = json['531'];
    d441 = json['441'];
    d442 = json['442'];
    d443 = json['443'];
    d444 = json['444'];
    d445 = json['445'];
    d536 = json['536'];
    d526 = json['526'];
    d461 = json['461'];
    d462 = json['462'];
    d463 = json['463'];
    d464 = json['464'];
    d465 = json['465'];
    d451 = json['451'];
    d452 = json['452'];
    d453 = json['453'];
    d454 = json['454'];
    d455 = json['455'];
    d905 = json['905'];
    d903 = json['903'];
    d904 = json['904'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['531'] = this.d531;
    data['441'] = this.d441;
    data['442'] = this.d442;
    data['443'] = this.d443;
    data['444'] = this.d444;
    data['445'] = this.d445;
    data['536'] = this.d536;
    data['526'] = this.d526;
    data['461'] = this.d461;
    data['462'] = this.d462;
    data['463'] = this.d463;
    data['464'] = this.d464;
    data['465'] = this.d465;
    data['451'] = this.d451;
    data['452'] = this.d452;
    data['453'] = this.d453;
    data['454'] = this.d454;
    data['455'] = this.d455;
    data['905'] = this.d905;
    data['903'] = this.d903;
    data['904'] = this.d904;
    return data;
  }
}

class ProductInfo {
  List<Donation>? donation;

  ProductInfo({this.donation});

  ProductInfo.fromJson(Map<String, dynamic> json) {
    if (json['donation'] != null) {
      donation = <Donation>[];
      json['donation'].forEach((v) {
        donation!.add(new Donation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.donation != null) {
      data['donation'] = this.donation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Donation {
  String? image;
  String? title;

  Donation({this.image, this.title});

  Donation.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['title'] = this.title;
    return data;
  }
}

class Params {
  String? root;
  String? repo;
  String? merchantCode;
  int? merchantKey;
  String? secureKey;
  String? domainName;
  String? lang;
  List<String>? currencyCode;
  String? vendorType;

  Params(
      {this.root,
        this.repo,
        this.merchantCode,
        this.merchantKey,
        this.secureKey,
        this.domainName,
        this.lang,
        this.currencyCode,
        this.vendorType});

  Params.fromJson(Map<String, dynamic> json) {
    root = json['root'];
    repo = json['repo'];
    merchantCode = json['merchantCode'];
    merchantKey = json['merchantKey'];
    secureKey = json['secureKey'];
    domainName = json['domainName'];
    lang = json['lang'];
    currencyCode = json['currencyCode'].cast<String>();
    vendorType = json['vendorType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['root'] = this.root;
    data['repo'] = this.repo;
    data['merchantCode'] = this.merchantCode;
    data['merchantKey'] = this.merchantKey;
    data['secureKey'] = this.secureKey;
    data['domainName'] = this.domainName;
    data['lang'] = this.lang;
    data['currencyCode'] = this.currencyCode;
    data['vendorType'] = this.vendorType;
    return data;
  }
}