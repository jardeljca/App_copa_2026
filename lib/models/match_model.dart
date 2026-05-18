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
      id: json['id'],
      homeTeam: TeamModel.fromJson(json['homeTeam']),
      awayTeam: TeamModel.fromJson(json['awayTeam']),
      homeScore: json['homeScore'],
      awayScore: json['awayScore'],
      date: DateTime.parse(json['date']),
      status: _parseStatus(json['status']),
      minute: json['minute'],
      stage: json['stage'],
      venue: json['venue'],
    );
  }

  static MatchStatus _parseStatus(String status) {
    switch (status.toLowerCase()) {
      case 'live': return MatchStatus.live;
      case 'finished': return MatchStatus.finished;
      default: return MatchStatus.scheduled;
    }
  }
}
