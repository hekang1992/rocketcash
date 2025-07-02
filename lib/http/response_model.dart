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
  PhoenixModel? phoenix;
  int? browsing;
  List<Fortunemodel>? fortune;

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
    this.phoenix,
    this.browsing,
    this.fortune,
  });

  factory MaidenModel.fromJson(Map<String, dynamic> json) {
    return MaidenModel(
      fairy: json['fairy'],
      blow: json['blow'],
      rpgs: json['rpgs'],
      activate: json['activate'],
      mechanical: json['mechanical'],
      reverberated: json['reverberated'],
      browsing: json['browsing'],
      phoenix: json['phoenix'] != null
          ? PhoenixModel.fromJson(json['phoenix'])
          : null,
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
      fortune: json['fortune'] != null
          ? (json['fortune'] as List)
                .map((item) => Fortunemodel.fromJson(item))
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
      'fortune': fortune?.map((model) => model.toJson()).toList(),
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
  List<KeyboardModel>? keyboard;

  KeyboardModel({this.activate, this.consume, this.keyboard});

  factory KeyboardModel.fromJson(Map<String, dynamic> json) {
    return KeyboardModel(
      activate: json['activate'],
      consume: json['consume'],
      keyboard: json['keyboard'] != null
          ? (json['keyboard'] as List)
                .map((item) => KeyboardModel.fromJson(item))
                .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'activate': activate,
      'consume': consume,
      'keyboard': keyboard?.map((model) => model.toJson()).toList(),
    };
  }
}

class PhoenixModel {
  String? mountain;
  String? rpgs;
  int? shock;

  PhoenixModel({this.mountain, this.rpgs, this.shock});

  factory PhoenixModel.fromJson(Map<String, dynamic> json) {
    return PhoenixModel(
      mountain: json['mountain'],
      rpgs: json['rpgs'],
      shock: json['shock'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'mountain': mountain, 'rpgs': rpgs, 'shock': shock};
  }
}

class Fortunemodel {
  String? appeared;
  String? heartbeat;
  String? opportunities; // type 单选框，输入框，地区选择框
  String? salivating; // key
  String? friends; // 回写时候的值
  String? rates; // value
  int? plenty; // 键盘类型
  List<Unnoticedmodel>? unnoticed;

  Fortunemodel({
    this.appeared,
    this.heartbeat,
    this.opportunities,
    this.salivating,
    this.friends,
    this.rates,
    this.plenty,
    this.unnoticed,
  });

  factory Fortunemodel.fromJson(Map<String, dynamic> json) {
    return Fortunemodel(
      appeared: json['appeared'],
      heartbeat: json['heartbeat'],
      opportunities: json['opportunities'],
      salivating: json['salivating'],
      friends: json['friends'],
      rates: json['rates'],
      plenty: json['plenty'],
      unnoticed: json['unnoticed'] != null
          ? (json['unnoticed'] as List)
                .map((item) => Unnoticedmodel.fromJson(item))
                .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appeared'] = appeared;
    data['heartbeat'] = heartbeat;
    data['opportunities'] = opportunities;
    data['salivating'] = salivating;
    data['friends'] = friends;
    data['rates'] = rates;
    data['plenty'] = plenty;
    data['unnoticed'] = unnoticed?.map((model) => model.toJson()).toList();
    return data;
  }
}

class Unnoticedmodel {
  String? activate;
  int? rates;
  bool? select;

  Unnoticedmodel({this.activate, this.rates, this.select});

  factory Unnoticedmodel.fromJson(Map<String, dynamic> json) {
    return Unnoticedmodel(
      activate: json['activate'],
      rates: json['rates'],
      select: json['select'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'activate': activate, 'rates': rates, 'select': select};
  }
}
