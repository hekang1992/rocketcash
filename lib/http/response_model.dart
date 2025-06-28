class BaseModel {
  String? salivating;
  String? companion;
  MaidenModel? maiden;

  BaseModel({this.salivating, this.companion, this.maiden});

  factory BaseModel.fromJson(Map<String, dynamic> json) {
    return BaseModel(
      salivating: json['salivating'],
      companion: json['companion'],
      maiden: MaidenModel.fromJson(json['maiden']),
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
  String? rpgs; //url_scheme

  MaidenModel({this.fairy, this.blow, this.greatly, this.points, this.rpgs});

  factory MaidenModel.fromJson(Map<String, dynamic> json) {
    return MaidenModel(
      fairy: json['fairy'],
      blow: json['blow'],
      rpgs: json['rpgs'],
      greatly: json['greatly'] != null
          ? GreatlyModel.fromJson(json['greatly'])
          : null,
      points: json['points'] != null
          ? GreatlyModel.fromJson(json['points'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fairy': fairy,
      'blow': blow,
      'greatly': greatly,
      'points': points,
      'rpgs': rpgs,
    };
  }
}

class GreatlyModel {
  String? rates;
  List<TicketsModel>? tickets;

  GreatlyModel({this.rates, this.tickets});

  factory GreatlyModel.fromJson(Map<String, dynamic> json) {
    if (json['tickets'] == null) {
      return GreatlyModel(rates: json['rates'], tickets: []);
    }

    List<TicketsModel> ticketList = [];
    if (json['tickets'] is List) {
      final List<dynamic> ticketJsonList = json['tickets'];
      ticketList = ticketJsonList
          .map((item) => TicketsModel.fromJson(item))
          .toList();
    }

    return GreatlyModel(rates: json['rates'], tickets: ticketList);
  }

  Map<String, dynamic> toJson() {
    return {
      'rates': rates,
      'tickets': tickets?.map((ticket) => ticket.toJson()).toList(),
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
