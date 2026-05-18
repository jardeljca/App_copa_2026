import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/match_card.dart';
import '../core/theme/app_theme.dart';
import '../providers/match_provider.dart';
import '../models/match_model.dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        title: const Text(
          'CALENDÁRIO',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 2),
        ),
      ),
      body: DefaultTabController(
        length: 3,
            child: Column(
          children: [
            TabBar(
              isScrollable: true,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              tabAlignment: TabAlignment.start,
              dividerColor: Colors.transparent,
              indicatorColor: const Color(0xFF00E676),
              labelColor: const Color(0xFF00E676),
              unselectedLabelColor: Colors.grey,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                color: const Color(0xFF00E676).withOpacity(0.08),
                borderRadius: BorderRadius.circular(20),
              ),
              tabs: const [
                Tab(text: 'TODOS'),
                Tab(text: 'HOJE'),
                Tab(text: 'AMANHÃ'),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  _MatchesList(filter: _MatchesFilter.all),
                  _MatchesList(filter: _MatchesFilter.today),
                  _MatchesList(filter: _MatchesFilter.tomorrow),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _MatchesFilter { all, today, tomorrow }

class _MatchesList extends StatelessWidget {
  final _MatchesFilter filter;

  const _MatchesList({required this.filter});

  @override
  Widget build(BuildContext context) {
    return Consumer<MatchProvider>(builder: (context, provider, _) {
      if (provider.isLoading) {
        return const Center(child: Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator()));
      }

      final now = DateTime.now();
      DateTime startOfDay(DateTime dt) => DateTime(dt.year, dt.month, dt.day);
      final todayStart = startOfDay(now);
      final tomorrowStart = startOfDay(now.add(const Duration(days: 1)));

      List<MatchModel> items = provider.upcoming;
      if (filter == _MatchesFilter.today) {
        items = items.where((m) => startOfDay(m.date.toLocal()) == todayStart).toList();
      } else if (filter == _MatchesFilter.tomorrow) {
        items = items.where((m) => startOfDay(m.date.toLocal()) == tomorrowStart).toList();
      }

      if (items.isEmpty) {
        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: Text(
                'Nenhuma partida encontrada.',
                style: TextStyle(color: Colors.white.withOpacity(0.6)),
              ),
            ),
          ],
        );
      }

      return ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(height: 15),
        itemBuilder: (context, index) {
          final m = items[index];
          return MatchCard(isLive: m.status == MatchStatus.live, match: m);
        },
      );
    });
  }
}
