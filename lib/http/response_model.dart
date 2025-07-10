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
  TrainedModel? trained;
  EssenceModel? essence;
  int? functions;
  GreatlyModel? uis;
  DishearteninglyModel? dishearteningly;

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
    this.trained,
    this.essence,
    this.functions,
    this.uis,
    this.dishearteningly,
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
      functions: json['functions'],
      dishearteningly: json['dishearteningly'] != null
          ? DishearteninglyModel.fromJson(json['dishearteningly'])
          : null,
      phoenix: json['phoenix'] != null
          ? PhoenixModel.fromJson(json['phoenix'])
          : null,
      greatly: json['greatly'] != null
          ? GreatlyModel.fromJson(json['greatly'])
          : null,
      points: json['points'] != null
          ? GreatlyModel.fromJson(json['points'])
          : null,
      uis: json['uis'] != null ? GreatlyModel.fromJson(json['uis']) : null,
      function: json['function'] != null
          ? FunctionModel.fromJson(json['function'])
          : null,
      trained: json['trained'] != null
          ? TrainedModel.fromJson(json['trained'])
          : null,
      subtle: json['subtle'] != null
          ? SubtleModel.fromJson(json['subtle'])
          : null,
      essence: json['essence'] != null
          ? EssenceModel.fromJson(json['essence'])
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
      'trained': trained?.toJson(),
      'essence': essence?.toJson(),
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
  String? skill;
  String? companion;

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
    this.skill,
    this.companion,
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
      skill: json['skill'],
      companion: json['companion'],
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
      'skill': skill,
      'companion': companion,
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
  String? glowing;

  SubtleModel({this.columnText, this.termDesc, this.screen, this.glowing});

  factory SubtleModel.fromJson(Map<String, dynamic> json) {
    return SubtleModel(
      termDesc: json['termDesc'],
      screen: json['screen'],
      glowing: json['glowing'],
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
  String? activate; //name
  String? consume;
  String? facing;
  String? suitable; //phone
  String? target; //关系的key
  String? threat; //
  String? relationText;
  List<KeyboardModel>? keyboard;
  List<EmployingModel>? employing;
  ChosenModel? chosen;

  KeyboardModel({
    this.activate,
    this.consume,
    this.keyboard,
    this.facing,
    this.suitable,
    this.target,
    this.employing,
    this.threat,
    this.relationText,
    this.chosen,
  });

  factory KeyboardModel.fromJson(Map<String, dynamic> json) {
    return KeyboardModel(
      activate: json['activate'],
      consume: json['consume'],
      facing: json['facing'],
      suitable: json['suitable'],
      target: json['target'],
      threat: json['threat'],
      relationText: json['relationText'],
      keyboard: json['keyboard'] != null
          ? (json['keyboard'] as List)
                .map((item) => KeyboardModel.fromJson(item))
                .toList()
          : [],
      employing: json['employing'] != null
          ? (json['employing'] as List)
                .map((item) => EmployingModel.fromJson(item))
                .toList()
          : [],
      chosen: json['chosen'] != null
          ? ChosenModel.fromJson(json['chosen'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'activate': activate,
      'consume': consume,
      'facing': facing,
      'suitable': suitable,
      'target': target,
      'threat': threat,
      'relationText': relationText,
      'chosen': chosen?.toJson(),
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
  List<Fortunemodel>? fortune;

  Fortunemodel({
    this.appeared,
    this.heartbeat,
    this.opportunities,
    this.salivating,
    this.friends,
    this.rates,
    this.plenty,
    this.unnoticed,
    this.fortune,
  });

  factory Fortunemodel.fromJson(Map<String, dynamic> json) {
    return Fortunemodel(
      appeared: json['appeared'],
      heartbeat: json['heartbeat'],
      opportunities: json['opportunities'],
      salivating: json['salivating'],
      friends: json['friends'],
      rates: json['rates'].toString(),
      plenty: json['plenty'],
      unnoticed: json['unnoticed'] != null
          ? (json['unnoticed'] as List)
                .map((item) => Unnoticedmodel.fromJson(item))
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appeared'] = appeared;
    data['heartbeat'] = heartbeat;
    data['opportunities'] = opportunities;
    data['salivating'] = salivating;
    data['friends'] = friends;
    data['rates'] = rates;
    data['plenty'] = plenty;
    data['unnoticed'] = unnoticed?.map((model) => model.toJson()).toList();
    data['fortune'] = fortune?.map((model) => model.toJson()).toList();
    return data;
  }
}

class Unnoticedmodel {
  String? activate;
  String? rates;
  bool? select;
  String? equipped;

  Unnoticedmodel({this.activate, this.rates, this.select, this.equipped});

  factory Unnoticedmodel.fromJson(Map<String, dynamic> json) {
    return Unnoticedmodel(
      activate: json['activate'],
      rates: json['rates'].toString(),
      select: json['select'],
      equipped: json['equipped'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'activate': activate,
      'rates': rates,
      'select': select,
      'equipped': equipped,
    };
  }
}

class TrainedModel {
  List<KeyboardModel>? keyboard;

  TrainedModel({this.keyboard});

  factory TrainedModel.fromJson(Map<String, dynamic> json) {
    return TrainedModel(
      keyboard: json['keyboard'] != null
          ? (json['keyboard'] as List)
                .map((item) => KeyboardModel.fromJson(item))
                .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'keyboard': keyboard?.map((model) => model.toJson()).toList()};
  }
}

class EmployingModel {
  String? activate;
  String? rates;

  EmployingModel({this.activate, this.rates});

  factory EmployingModel.fromJson(Map<String, dynamic> json) {
    return EmployingModel(activate: json['activate'], rates: json['rates']);
  }

  Map<String, dynamic> toJson() {
    return {'activate': activate, 'rates': rates};
  }
}

class ChosenModel {
  String? bring;
  String? convinced;
  String? bridirtng;
  String? draw;
  String? heights;
  String? may;
  String? permitted;
  String? uphold;
  String? venerable;
  String? wish;
  int? glad;
  int? buried;
  String? dirt;

  ChosenModel({
    this.bring,
    this.convinced,
    this.bridirtng,
    this.draw,
    this.heights,
    this.may,
    this.permitted,
    this.uphold,
    this.venerable,
    this.wish,
    this.glad,
    this.buried,
    this.dirt,
  });

  // 从 JSON 构造对象
  factory ChosenModel.fromJson(Map<String, dynamic> json) {
    return ChosenModel(
      bring: json['bring'],
      convinced: json['convinced'],
      bridirtng: json['bridirtng'],
      draw: json['draw'],
      heights: json['heights'],
      may: json['may'],
      permitted: json['permitted'],
      uphold: json['uphold'],
      venerable: json['venerable'],
      wish: json['wish'],
      glad: json['glad'],
      buried: json['buried'],
      dirt: json['dirt'],
    );
  }

  // 将对象转为 JSON 可序列化格式
  Map<String, dynamic> toJson() {
    return {
      'bring': bring,
      'convinced': convinced,
      'bridirtng': bridirtng,
      'draw': draw,
      'heights': heights,
      'may': may,
      'permitted': permitted,
      'uphold': uphold,
      'venerable': venerable,
      'wish': wish,
      'glad': glad,
      'buried': buried,
    };
  }
}

class EssenceModel {
  String? amounts;
  String? rare;
  String? resource;
  String? valuable;

  EssenceModel({this.amounts, this.rare, this.resource, this.valuable});

  factory EssenceModel.fromJson(Map<String, dynamic> json) {
    return EssenceModel(
      amounts: json['amounts'],
      rare: json['rare'],
      resource: json['resource'],
      valuable: json['valuable'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amounts': amounts,
      'rare': rare,
      'resource': resource,
      'valuable': valuable,
    };
  }
}

class DishearteninglyModel {
  String? rates;
  List<TicketsModel>? tickets;

  DishearteninglyModel({this.rates, this.tickets});

  factory DishearteninglyModel.fromJson(Map<String, dynamic> json) {
    return DishearteninglyModel(
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
