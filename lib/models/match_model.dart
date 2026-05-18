import '../models/team_model.dart';

enum MatchStatus { scheduled, live, finished }

class MatchModel {
  final String id;
  final TeamModel homeTeam;
  final TeamModel awayTeam;
  final int? homeScore;
  final int? awayScore;
  final DateTime date;
  final MatchStatus status;
  final String? minute;
  final String stage;
  final String venue;

  MatchModel({
    required this.id,
    required this.homeTeam,
    required this.awayTeam,
    this.homeScore,
    this.awayScore,
    required this.date,
    required this.status,
    this.minute,
    required this.stage,
    required this.venue,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      id: json['id']?.toString() ?? '',
      homeTeam: TeamModel.fromJson(_asMap(json['homeTeam'])),
      awayTeam: TeamModel.fromJson(_asMap(json['awayTeam'])),
      homeScore: _toInt(json['homeScore']),
      awayScore: _toInt(json['awayScore']),
      date: DateTime.tryParse(json['date']?.toString() ?? '') ?? DateTime.fromMillisecondsSinceEpoch(0),
      status: _parseStatus(json['status']?.toString() ?? 'scheduled'),
      minute: json['minute']?.toString(),
      stage: json['stage']?.toString() ?? '',
      venue: json['venue']?.toString() ?? '',
    );
  }

  factory MatchModel.fromFootballData(Map<String, dynamic> json) {
    final score = _asMap(json['score']);
    final fullTime = _asMap(score['fullTime']);
    final homeTeam = _asMap(json['homeTeam']);
    final awayTeam = _asMap(json['awayTeam']);
    final stageMap = _asMap(json['stage']);
    final competitionMap = _asMap(json['competition']);
    final venueMap = _asMap(json['area']);
    final stageName = stageMap['name']?.toString() ?? competitionMap['name']?.toString() ?? '';
    final venue = venueMap['name']?.toString() ?? '';

    return MatchModel(
      id: json['id']?.toString() ?? '',
      homeTeam: TeamModel.fromFootballData(homeTeam),
      awayTeam: TeamModel.fromFootballData(awayTeam),
      homeScore: _toInt(fullTime['home']),
      awayScore: _toInt(fullTime['away']),
      date: DateTime.tryParse(json['utcDate']?.toString() ?? '') ?? DateTime.fromMillisecondsSinceEpoch(0),
      status: _parseStatus(json['status']?.toString() ?? 'scheduled'),
      minute: _minuteFromStatus(json),
      stage: stageName,
      venue: venue,
    );
  }

  static MatchStatus _parseStatus(String status) {
    switch (status.toLowerCase()) {
      case 'live':
      case 'in_play':
      case 'paused':
        return MatchStatus.live;
      case 'finished':
      case 'timed':
        return MatchStatus.finished;
      default: return MatchStatus.scheduled;
    }
  }

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    return int.tryParse(value.toString());
  }

  static Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return <String, dynamic>{};
  }

  static String? _minuteFromStatus(Map<String, dynamic> json) {
    final status = json['status']?.toString() ?? '';
    final minute = json['minute']?.toString();
    if (minute != null && minute.isNotEmpty) return minute;
    if (status == 'IN_PLAY' || status == 'PAUSED') return 'Ao vivo';
    return null;
  }
}
