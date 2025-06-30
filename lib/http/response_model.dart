class BaseModel {
  String? salivating;
  String? companion;
  MaidenModel? maiden;

  BaseModel({this.salivating, this.companion, this.maiden});

  factory BaseModel.fromJson(Map<String, dynamic> json) {
    return BaseModel(
      salivating: json['salivating'],
      companion: json['companion'],
      maiden: json['maiden'] != null
          ? MaidenModel.fromJson(json['maiden'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'salivating': salivating,
      'companion': companion,
      'maiden': maiden?.toJson(),
    };
  }
}

class MaidenModel {
  String? fairy;
  String? blow;
  GreatlyModel? greatly;
  GreatlyModel? points;
  String? rpgs;
  FunctionModel? function;
  SubtleModel? subtle;
  List<TransformedModel>? transformed;
  List<KeyboardModel>? keyboard;
  String? activate;
  String? mechanical;
  String? reverberated;

  MaidenModel({
    this.fairy,
    this.blow,
    this.greatly,
    this.points,
    this.rpgs,
    this.function,
    this.subtle,
    this.transformed,
    this.keyboard,
    this.activate,
    this.mechanical,
    this.reverberated,
  });

  factory MaidenModel.fromJson(Map<String, dynamic> json) {
    return MaidenModel(
      fairy: json['fairy'],
      blow: json['blow'],
      rpgs: json['rpgs'],
      activate: json['activate'],
      mechanical: json['mechanical'],
      reverberated: json['reverberated'],
      greatly: json['greatly'] != null
          ? GreatlyModel.fromJson(json['greatly'])
          : null,
      points: json['points'] != null
          ? GreatlyModel.fromJson(json['points'])
          : null,
      function: json['function'] != null
          ? FunctionModel.fromJson(json['function'])
          : null,
      subtle: json['subtle'] != null
          ? SubtleModel.fromJson(json['subtle'])
          : null,
      transformed: json['transformed'] != null
          ? (json['transformed'] as List)
                .map((item) => TransformedModel.fromJson(item))
                .toList()
          : [],
      keyboard: json['keyboard'] != null
          ? (json['keyboard'] as List)
                .map((item) => KeyboardModel.fromJson(item))
                .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fairy': fairy,
      'blow': blow,
      'greatly': greatly?.toJson(),
      'points': points?.toJson(),
      'rpgs': rpgs,
      'function': function?.toJson(),
      'subtle': subtle?.toJson(),
      'transformed': transformed?.map((model) => model.toJson()).toList(),
      'keyboard': keyboard?.map((model) => model.toJson()).toList(),
    };
  }
}

class GreatlyModel {
  String? rates;
  List<TicketsModel>? tickets;

  GreatlyModel({this.rates, this.tickets});

  factory GreatlyModel.fromJson(Map<String, dynamic> json) {
    return GreatlyModel(
      rates: json['rates'],
      tickets: json['tickets'] != null
          ? (json['tickets'] as List)
                .map((item) => TicketsModel.fromJson(item))
                .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rates': rates,
      'tickets': tickets?.map((model) => model.toJson()).toList(),
    };
  }
}

class TicketsModel {
  String? activating;
  String? costs;
  String? disarray;
  String? draw;
  String? each;
  String? guess;
  String? pissed;
  int? three;
  String? paragraph;
  String? ticket;
  String? trolled;
  String? rpgs;

  TicketsModel({
    this.activating,
    this.costs,
    this.disarray,
    this.draw,
    this.each,
    this.guess,
    this.pissed,
    this.three,
    this.paragraph,
    this.ticket,
    this.trolled,
    this.rpgs,
  });

  factory TicketsModel.fromJson(Map<String, dynamic> json) {
    return TicketsModel(
      activating: json['activating'],
      costs: json['costs'],
      disarray: json['disarray'],
      draw: json['draw'],
      each: json['each'],
      guess: json['guess'],
      pissed: json['pissed'],
      three: json['three'],
      paragraph: json['paragraph'],
      ticket: json['ticket'],
      trolled: json['trolled'],
      rpgs: json['rpgs'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'activating': activating,
      'costs': costs,
      'disarray': disarray,
      'draw': draw,
      'each': each,
      'guess': guess,
      'pissed': pissed,
      'three': three,
      'paragraph': paragraph,
      'ticket': ticket,
      'trolled': trolled,
      'rpgs': rpgs,
    };
  }
}

class FunctionModel {
  String? appeared;
  String? process;
  String? supermysterious;

  FunctionModel({this.appeared, this.process, this.supermysterious});

  factory FunctionModel.fromJson(Map<String, dynamic> json) {
    return FunctionModel(
      appeared: json['appeared'],
      process: json['process'],
      supermysterious: json['supermysterious'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appeared': appeared,
      'process': process,
      'supermysterious': supermysterious,
    };
  }
}

class SubtleModel {
  String? termDesc;
  String? screen;
  ColumnTextModel? columnText;

  SubtleModel({this.columnText, this.termDesc, this.screen});

  factory SubtleModel.fromJson(Map<String, dynamic> json) {
    return SubtleModel(
      termDesc: json['termDesc'],
      screen: json['screen'],
      columnText: json['columnText'] != null
          ? ColumnTextModel.fromJson(json['columnText'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'columnText': columnText?.toJson(),
      'termDesc': termDesc,
      'screen': screen,
    };
  }
}

class ColumnTextModel {
  TagModel? tag1;
  TagModel? tag2;

  ColumnTextModel({this.tag1, this.tag2});

  factory ColumnTextModel.fromJson(Map<String, dynamic> json) {
    return ColumnTextModel(
      tag1: json['tag1'] != null ? TagModel.fromJson(json['tag1']) : null,
      tag2: json['tag2'] != null ? TagModel.fromJson(json['tag2']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'tag1': tag1?.toJson(), 'tag2': tag2?.toJson()};
  }
}

class TagModel {
  String? appeared;
  String? threat;

  TagModel({this.appeared, this.threat});

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(appeared: json['appeared'], threat: json['threat']);
  }

  Map<String, dynamic> toJson() {
    return {'appeared': appeared, 'threat': threat};
  }
}

class TransformedModel {
  String? appeared;
  String? lap; // 图片
  String? supermysterious;
  int? shock; // 是否已完成认证 0 否 1 是

  TransformedModel({this.appeared, this.lap, this.supermysterious, this.shock});

  factory TransformedModel.fromJson(Map<String, dynamic> json) {
    return TransformedModel(
      appeared: json['appeared'],
      lap: json['lap'],
      supermysterious: json['supermysterious'],
      shock: json['shock'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appeared': appeared,
      'lap': lap,
      'supermysterious': supermysterious,
      'shock': shock,
    };
  }
}

class KeyboardModel {
  String? activate;
  String? consume;

  KeyboardModel({this.activate, this.consume});

  factory KeyboardModel.fromJson(Map<String, dynamic> json) {
    return KeyboardModel(activate: json['activate'], consume: json['consume']);
  }

  Map<String, dynamic> toJson() {
    return {'activate': activate, 'consume': consume};
  }
}
