import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/app_theme.dart';

class StandingsScreen extends StatelessWidget {
  const StandingsScreen({super.key});

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
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CLASSIFICAÇÃO',
                      style: GoogleFonts.outfit(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'FASE DE GRUPOS',
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _buildGroupCard(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGroupCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBg.withOpacity(0.92),
        borderRadius: BorderRadius.circular(36),
        border: Border.all(color: AppTheme.borderSide),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'GRUPO A',
                  style: GoogleFonts.outfit(
                    color: AppTheme.emerald500,
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                    letterSpacing: 2,
                  ),
                ),
                Row(children: [
                  _buildStatHeader('J'),
                  const SizedBox(width: 16),
                  _buildStatHeader('SG'),
                  const SizedBox(width: 16),
                  _buildStatHeader('PT'),
                ])
              ],
            ),
          ),
          _buildTeamRow('🇧🇷', 'BRASIL', 3, 5, 9, 0, isQualified: true),
          _buildDivider(),
          _buildTeamRow('🇫🇷', 'FRANÇA', 3, 2, 6, 1, isQualified: true),
          _buildDivider(),
          _buildTeamRow('🇯🇵', 'JAPÃO', 3, -1, 3, 2),
          _buildDivider(),
          _buildTeamRow('🇲🇦', 'MARROCOS', 3, -6, 0, 3),
          const SizedBox(height: 12),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildStatHeader(String label) {
    return SizedBox(
      width: 20,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: GoogleFonts.outfit(
          fontSize: 10,
          fontWeight: FontWeight.w900,
          color: Colors.white.withOpacity(0.2),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      color: Colors.white.withOpacity(0.05),
      indent: 24,
      endIndent: 24,
    );
  }

  Widget _buildTeamRow(String flag, String name, int played, int goalDiff, int points, int rank, {bool isQualified = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          SizedBox(
            width: 16,
            child: Text(
              (rank + 1).toString(),
              style: GoogleFonts.outfit(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                color: isQualified ? AppTheme.emerald500 : Colors.white.withOpacity(0.15),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: Center(child: Text(flag, style: const TextStyle(fontSize: 16))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: GoogleFonts.outfit(
                fontSize: 13,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: -0.2,
              ),
            ),
          ),
          SizedBox(
            width: 20,
            child: Text(
              played.toString(),
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white.withOpacity(0.4),
              ),
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 20,
            child: Text(
              goalDiff > 0 ? '+$goalDiff' : goalDiff.toString(),
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white.withOpacity(0.4),
              ),
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 20,
            child: Text(
              points.toString(),
              textAlign: TextAlign.right,
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(36)),
      ),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Color(0xFF00E676),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'CLASSIFICADOS PARA AS OITAVAS',
            style: GoogleFonts.outfit(
              fontSize: 9,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
              color: Colors.white.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}
