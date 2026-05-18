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
      id: json['id'],
      name: json['name'],
      code: json['code'],
      flagUrl: json['flagUrl'],
    );
  }
}
