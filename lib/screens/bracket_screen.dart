import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/app_theme.dart';

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
            colors: [AppTheme.emerald500.withOpacity(0.05), AppTheme.background],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
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
                    const SizedBox(height: 6),
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
          const SizedBox(height: 16),
          Column(
            children: List.generate(
              matchCount == 0 ? 1 : matchCount,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: matchCount == 0 ? _buildWinnerCard() : _buildBracketMatch(index),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBracketMatch(int index) {
    final bool isPlaceHolder = index > 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: isPlaceHolder ? Colors.white.withOpacity(0.03) : AppTheme.borderSide),
      ),
      child: Opacity(
        opacity: isPlaceHolder ? 0.22 : 1.0,
        child: Column(
          children: [
            _BracketTeam(flag: '🇧🇷', name: 'BRASIL', score: '-'),
            const SizedBox(height: 12),
            _buildInternalDivider(),
            const SizedBox(height: 12),
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
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.emerald500.withOpacity(0.05),
        borderRadius: BorderRadius.circular(36),
        border: Border.all(color: AppTheme.emerald500.withOpacity(0.1)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.emerald500.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.emoji_events, color: AppTheme.emerald500, size: 28),
          ),
          const SizedBox(height: 12),
          Text(
            'GRANDE FINAL',
            style: GoogleFonts.outfit(
              color: AppTheme.emerald500,
              fontWeight: FontWeight.w900,
              fontSize: 10,
              letterSpacing: 2,
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

  const _BracketTeam({required this.flag, required this.name, required this.score, this.isOpponent = false});

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
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), shape: BoxShape.circle),
              child: Center(child: Text(flag, style: const TextStyle(fontSize: 14))),
            ),
            const SizedBox(width: 12),
            Text(name, style: GoogleFonts.outfit(fontWeight: FontWeight.w900, fontSize: 12, color: isOpponent ? Colors.white.withOpacity(0.4) : Colors.white)),
          ],
        ),
        Text(score, style: GoogleFonts.outfit(fontWeight: FontWeight.w900, fontSize: 12, color: isOpponent ? Colors.white.withOpacity(0.2) : Colors.white)),
      ],
    );
  }
}
