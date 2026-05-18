import 'package:flutter/material.dart';
import '../models/match_model.dart';
import '../widgets/match_card.dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'CALENDÁRIO',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.black, letterSpacing: 2),
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              dividerColor: Colors.transparent,
              indicatorColor: const Color(0xFF00E676),
              labelColor: const Color(0xFF00E676),
              unselectedLabelColor: Colors.grey,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
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
