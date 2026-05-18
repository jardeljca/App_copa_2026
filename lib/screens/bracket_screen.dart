import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BracketScreen extends StatelessWidget {
  const BracketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0.8, -0.6),
            radius: 1.2,
            colors: [
              const Color(0xFF00E676).withOpacity(0.05),
              const Color(0xFF0D0D0D),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MATA-MATA',
                    style: GoogleFonts.outfit(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'CAMINHO PARA A TAÇA',
                    style: GoogleFonts.outfit(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 4,
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStage('OITAVAS', 4),
                    _buildStage('QUARTAS', 2),
                    _buildStage('SEMIFINAL', 1),
                    _buildStage('FINAL', 0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStage(String title, int matchCount) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(right: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: Colors.white.withOpacity(0.2),
              letterSpacing: 4,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: matchCount == 0 ? 1 : matchCount,
              itemBuilder: (context, index) {
                if (matchCount == 0) return _buildWinnerCard();
                return _buildBracketMatch(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBracketMatch(int index) {
    final bool isPlaceHolder = index > 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isPlaceHolder ? Colors.white.withOpacity(0.03) : Colors.white.withOpacity(0.08),
          style: isPlaceHolder ? BorderStyle.solid : BorderStyle.solid,
        ),
      ),
      child: Opacity(
        opacity: isPlaceHolder ? 0.2 : 1.0,
        child: Column(
          children: [
            _BracketTeam(flag: '🇧🇷', name: 'BRASIL', score: '-'),
            const SizedBox(height: 16),
            _buildInternalDivider(),
            const SizedBox(height: 16),
            _BracketTeam(flag: '🇫🇷', name: 'FRANÇA', score: '-', isOpponent: true),
          ],
        ),
      ),
    );
  }

  Widget _buildInternalDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.white.withOpacity(0.05), height: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'VS',
            style: GoogleFonts.outfit(
              fontSize: 8,
              fontWeight: FontWeight.w900,
              color: Colors.white.withOpacity(0.1),
            ),
          ),
        ),
        Expanded(child: Divider(color: Colors.white.withOpacity(0.05), height: 1)),
      ],
    );
  }

  Widget _buildWinnerCard() {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF00E676).withOpacity(0.05),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: const Color(0xFF00E676).withOpacity(0.1)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF00E676).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.emoji_events, color: Color(0xFF00E676), size: 32),
          ),
          const SizedBox(height: 20),
          Text(
            'GRANDE FINAL',
            style: GoogleFonts.outfit(
              color: const Color(0xFF00E676),
              fontWeight: FontWeight.w900,
              fontSize: 10,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'LUSAIL STADIUM',
            style: GoogleFonts.outfit(
              color: Colors.white.withOpacity(0.3),
              fontWeight: FontWeight.w900,
              fontSize: 9,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _BracketTeam extends StatelessWidget {
  final String flag;
  final String name;
  final String score;
  final bool isOpponent;

  const _BracketTeam({
    required this.flag,
    required this.name,
    required this.score,
    this.isOpponent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Center(child: Text(flag, style: const TextStyle(fontSize: 14))),
            ),
            const SizedBox(width: 12),
            Text(
              name,
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w900,
                fontSize: 12,
                color: isOpponent ? Colors.white.withOpacity(0.4) : Colors.white,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
        Text(
          score,
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w900,
            fontSize: 12,
            color: isOpponent ? Colors.white.withOpacity(0.2) : Colors.white,
          ),
        ),
      ],
    );
  }
}
