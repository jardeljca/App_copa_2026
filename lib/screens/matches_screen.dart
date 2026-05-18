import 'package:flutter/material.dart';
import '../widgets/match_card.dart';
import '../core/theme/app_theme.dart';

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
                  _MatchesList(),
                  _MatchesList(),
                  _MatchesList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MatchesList extends StatelessWidget {
  const _MatchesList();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: 5,
      separatorBuilder: (context, index) => const SizedBox(height: 15),
      itemBuilder: (context, index) => const MatchCard(isLive: false),
    );
  }
}
