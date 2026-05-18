import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../core/theme/app_theme.dart';
import '../models/match_model.dart';

class MatchCard extends StatelessWidget {
  final bool isLive;
  final MatchModel? match;

  const MatchCard({super.key, required this.isLive, this.match});

  @override
  Widget build(BuildContext context) {
    final hasMatch = match != null;
    final homeTeamName = match?.homeTeam.name.isNotEmpty == true ? match!.homeTeam.name : 'BRASIL';
    final awayTeamName = match?.awayTeam.name.isNotEmpty == true ? match!.awayTeam.name : 'FRANÇA';
    final homeScore = match?.homeScore?.toString() ?? '2';
    final awayScore = match?.awayScore?.toString() ?? '1';
    final venue = match?.venue.isNotEmpty == true ? match!.venue : 'METLIFE STADIUM, NY';
    final stageLabel = match?.stage.isNotEmpty == true ? match!.stage.toUpperCase() : 'OITAVAS';
    final timeLabel = match != null
        ? DateFormat('HH:mm', 'pt_BR').format(match!.date.toLocal())
        : '16:00';
    final liveLabel = match?.minute != null ? 'AO VIVO ${match!.minute}' : 'AO VIVO 65\'';

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBg.withOpacity(0.92),
        borderRadius: BorderRadius.circular(36),
        border: Border.all(color: AppTheme.borderSide),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      stageLabel,
                      style: GoogleFonts.outfit(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: Colors.white.withOpacity(0.3),
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      hasMatch ? 'REAL' : 'GERAL',
                      style: GoogleFonts.outfit(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: Colors.white.withOpacity(0.6),
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
                if (isLive)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF3B30),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF3B30).withOpacity(0.28),
                          blurRadius: 12,
                          spreadRadius: 1,
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          liveLabel,
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      timeLabel,
                      style: GoogleFonts.outfit(
                        color: Colors.white.withOpacity(0.4),
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          homeTeamName.toUpperCase(),
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                            letterSpacing: -0.5,
                          ),
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 12),
                      _TeamBadge(label: match?.homeTeam.code ?? 'BRA', fallback: '🇧🇷'),
                    ],
                  ),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 70),
                  child: Align(
                    alignment: Alignment.center,
                    child: isLive
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                homeScore,
                                style: GoogleFonts.outfit(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                  color: AppTheme.emerald500,
                                  shadows: [
                                    Shadow(
                                      color: AppTheme.emerald500.withOpacity(0.45),
                                      blurRadius: 14,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  ':',
                                  style: GoogleFonts.outfit(
                                    color: Colors.white.withOpacity(0.1),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                              ),
                              Text(
                                awayScore,
                                style: GoogleFonts.outfit(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                  color: AppTheme.emerald500,
                                  shadows: [
                                    Shadow(
                                      color: AppTheme.emerald500.withOpacity(0.4),
                                      blurRadius: 10,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.white.withOpacity(0.05)),
                            ),
                            child: Text(
                              timeLabel,
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.w900,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _TeamBadge(label: match?.awayTeam.code ?? 'FRA', fallback: '🇫🇷'),
                      const SizedBox(width: 12),
                      Flexible(
                        child: Text(
                          awayTeamName.toUpperCase(),
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                            letterSpacing: -0.5,
                          ),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.white.withOpacity(0.05)],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    venue,
                    style: GoogleFonts.outfit(
                      fontSize: 10,
                      color: Colors.white.withOpacity(0.2),
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 1,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.white.withOpacity(0.05), Colors.transparent],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TeamBadge extends StatelessWidget {
  final String label;
  final String fallback;

  const _TeamBadge({required this.label, required this.fallback});

  @override
  Widget build(BuildContext context) {
    final initials = label.trim().isNotEmpty
        ? label.trim().split(RegExp(r'\s+')).take(2).map((part) => part.isNotEmpty ? part[0] : '').join()
        : '';

    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          initials.isNotEmpty ? initials.toUpperCase() : fallback,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}