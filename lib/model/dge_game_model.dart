import 'dart:convert';

DgeGameModel gameInfoModelFromJson(String str) =>
    DgeGameModel.fromJson(json.decode(str));

String gameInfoModelToJson(DgeGameModel data) => json.encode(data.toJson());

class DgeGameModel {
  DgeGameModel({
    this.errorCode,
    this.message,
    this.data,
  });

  int? errorCode;
  String? message;
  Data? data;

  factory DgeGameModel.fromJson(Map<String, dynamic> json) => DgeGameModel(
        errorCode: json["errorCode"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "errorCode": errorCode,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.games,
    this.currentTime,
  });

  Games? games;
  CurrentTime? currentTime;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        games: Games.fromJson(json["games"]),
        currentTime: CurrentTime.fromJson(json["currentTime"]),
      );

  Map<String, dynamic> toJson() => {
        "games": games?.toJson(),
        "currentTime": currentTime?.toJson(),
      };
}

class CurrentTime {
  CurrentTime({
    this.date,
    this.timezoneType,
    this.timezone,
  });

  DateTime? date;
  int? timezoneType;
  String? timezone;

  factory CurrentTime.fromJson(Map<String, dynamic> json) => CurrentTime(
        date: DateTime.parse(json["date"]),
        timezoneType: json["timezone_type"],
        timezone: json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "date": date?.toIso8601String(),
        "timezone_type": timezoneType,
        "timezone": timezone,
      };
}

class Games {
  Games({
    this.twelvebytwentyfour,
    this.powerball,
    this.superkeno,
    this.luckysix,
    this.thailotteryhighfrequency,
    this.fivebyninety,
  });

  Fivebyninety? twelvebytwentyfour;
  Fivebyninety? powerball;
  Fivebyninety? superkeno;
  Fivebyninety? luckysix;
  Fivebyninety? thailotteryhighfrequency;
  Fivebyninety? fivebyninety;

  factory Games.fromJson(Map<String, dynamic> json) => Games(
        twelvebytwentyfour: Fivebyninety.fromJson(json["TWELVEBYTWENTYFOUR"]),
        powerball: Fivebyninety.fromJson(json["POWERBALL"]),
        superkeno: Fivebyninety.fromJson(json["SUPERKENO"]),
        luckysix: Fivebyninety.fromJson(json["LUCKYSIX"]),
        thailotteryhighfrequency:
            Fivebyninety.fromJson(json["THAILOTTERYHIGHFREQUENCY"]),
        fivebyninety: Fivebyninety.fromJson(json["FIVEBYNINETY"]),
      );

  Map<String, dynamic> toJson() => {
        "TWELVEBYTWENTYFOUR": twelvebytwentyfour?.toJson(),
        "POWERBALL": powerball?.toJson(),
        "SUPERKENO": superkeno?.toJson(),
        "LUCKYSIX": luckysix?.toJson(),
        "THAILOTTERYHIGHFREQUENCY": thailotteryhighfrequency?.toJson(),
        "FIVEBYNINETY": fivebyninety?.toJson(),
      };
}

class Fivebyninety {
  Fivebyninety({
    this.gameCode,
    this.datetime,
    this.estimatedJackpot,
    this.guaranteedJackpot,
    this.jackpotTitle,
    this.jackpotAmount,
    this.drawDate,
    this.extra,
    this.nextDrawDate,
    this.active,
  });

  String? gameCode;
  DateTime? datetime;
  String? estimatedJackpot;
  String? guaranteedJackpot;
  String? jackpotTitle;
  String? jackpotAmount;
  DateTime? drawDate;
  Extra? extra;
  DateTime? nextDrawDate;
  String? active;

  factory Fivebyninety.fromJson(Map<String, dynamic> json) => Fivebyninety(
        gameCode: json["game_code"],
        datetime: DateTime.parse(json["datetime"]),
        estimatedJackpot: json["estimated_jackpot"],
        guaranteedJackpot: json["guaranteed_jackpot"],
        jackpotTitle: json["jackpot_title"],
        jackpotAmount: json["jackpot_amount"],
        drawDate: DateTime.parse(json["draw_date"]),
        extra: Extra.fromJson(json["extra"]),
        nextDrawDate: DateTime.parse(json["next_draw_date"]),
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "game_code": gameCode,
        "datetime": datetime?.toIso8601String(),
        "estimated_jackpot": estimatedJackpot,
        "guaranteed_jackpot": guaranteedJackpot,
        "jackpot_title": jackpotTitle,
        "jackpot_amount": jackpotAmount,
        "draw_date": drawDate?.toIso8601String(),
        "extra": extra?.toJson(),
        "next_draw_date": nextDrawDate?.toIso8601String(),
        "active": active,
      };
}

class Extra {
  Extra({
    this.currentDrawNumber,
    this.currentDrawFreezeDate,
    this.currentDrawStopTime,
    this.jackpotAmount,
    this.unitCostJson,
  });

  int? currentDrawNumber;
  DateTime? currentDrawFreezeDate;
  DateTime? currentDrawStopTime;
  double? jackpotAmount;
  List<UnitCostJson>? unitCostJson;

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
        currentDrawNumber: json["currentDrawNumber"],
        currentDrawFreezeDate: DateTime.parse(json["currentDrawFreezeDate"]),
        currentDrawStopTime: DateTime.parse(json["currentDrawStopTime"]),
        jackpotAmount: json["jackpotAmount"].toDouble(),
        unitCostJson: List<UnitCostJson>.from(
            json["unitCostJson"].map((x) => UnitCostJson.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "currentDrawNumber": currentDrawNumber,
        "currentDrawFreezeDate": currentDrawFreezeDate?.toIso8601String(),
        "currentDrawStopTime": currentDrawStopTime?.toIso8601String(),
        "jackpotAmount": jackpotAmount,
        "unitCostJson": unitCostJson != null
            ? List<dynamic>.from(unitCostJson!.map((x) => x.toJson()))
            : null,
      };
}

class UnitCostJson {
  UnitCostJson({
    this.currency,
    this.price,
  });

  String? currency;
  int? price;

  factory UnitCostJson.fromJson(Map<String, dynamic> json) => UnitCostJson(
        currency: json["currency"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "currency": currency,
        "price": price,
      };
}
