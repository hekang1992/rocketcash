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
      'model': maiden?.toJson(),
    };
  }
}

class MaidenModel {
  String? fairy;
  String? blow;

  MaidenModel({this.fairy, this.blow});

  factory MaidenModel.fromJson(Map<String, dynamic> json) {
    return MaidenModel(fairy: json['fairy'], blow: json['blow']);
  }

  Map<String, dynamic> toJson() {
    return {'fairy': fairy, 'blow': blow};
  }
}
