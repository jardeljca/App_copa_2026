class TeamModel {
  final String id;
  final String name;
  final String code;
  final String flagUrl;

  TeamModel({
    required this.id,
    required this.name,
    required this.code,
    required this.flagUrl,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      code: json['code']?.toString() ?? '',
      flagUrl: json['flagUrl']?.toString() ?? '',
    );
  }

  factory TeamModel.fromFootballData(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      code: json['tla']?.toString() ?? json['code']?.toString() ?? '',
      flagUrl: json['crest']?.toString() ?? json['flag']?.toString() ?? '',
    );
  }
}
