import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/match_model.dart';

class ApiService {
  static const String baseUrl = 'https://api.football-data.org/v4';
  static const String competitionCode = 'WC';
  static const String apiKey = String.fromEnvironment('FOOTBALL_DATA_TOKEN', defaultValue: '');

  static Map<String, String> _defaultHeaders() {
    final headers = <String, String>{'Accept': 'application/json'};
    if (apiKey.isNotEmpty) headers['X-Auth-Token'] = apiKey;
    return headers;
  }

  static Future<List<MatchModel>> fetchUpcomingMatches({int limit = 10}) async {
    final uri = Uri.parse('$baseUrl/competitions/$competitionCode/matches?status=SCHEDULED,IN_PLAY,PAUSED');
    final resp = await http.get(uri, headers: _defaultHeaders()).timeout(const Duration(seconds: 10));
    if (resp.statusCode != 200) throw Exception('API retornou ${resp.statusCode}');
    final body = json.decode(resp.body);
    final matches = body is Map<String, dynamic> ? body['matches'] : null;
    if (matches is List) {
      return matches
          .map((e) => MatchModel.fromFootballData(_normalizeMatchJson(e)))
          .take(limit)
          .toList();
    }
    throw Exception('Resposta inválida da API');
  }

  static Map<String, dynamic> _normalizeMatchJson(dynamic e) {
    if (e is Map<String, dynamic>) return e;
    return Map<String, dynamic>.from(e as Map);
  }

  static Future<List<Map<String, dynamic>>> fetchStandings() async {
    final uri = Uri.parse('$baseUrl/competitions/$competitionCode/standings');
    final resp = await http.get(uri, headers: _defaultHeaders()).timeout(const Duration(seconds: 10));
    if (resp.statusCode != 200) throw Exception('API retornou ${resp.statusCode}');
    final body = json.decode(resp.body);
    if (body is Map<String, dynamic>) {
      final standings = body['standings'];
      if (standings is List && standings.isNotEmpty) {
        final table = (standings.first as Map)['table'];
        if (table is List) {
          return table.map<Map<String, dynamic>>((row) {
            final team = Map<String, dynamic>.from(row['team'] ?? const {});
            return {
              'position': row['position'],
              'teamName': team['name'],
              'tla': team['tla'],
              'crest': team['crest'],
              'playedGames': row['playedGames'],
              'won': row['won'],
              'draw': row['draw'],
              'lost': row['lost'],
              'goalsFor': row['goalsFor'],
              'goalsAgainst': row['goalsAgainst'],
              'goalDifference': row['goalDifference'],
              'points': row['points'],
            };
          }).toList();
        }
      }
    }
    return [];
  }
}
