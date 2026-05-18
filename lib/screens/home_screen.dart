import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../core/theme/app_theme.dart';
import '../widgets/match_card.dart';
import '../providers/match_provider.dart';
import '../models/match_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(-0.85, -0.55),
            radius: 1.25,
            colors: [
              AppTheme.emerald500.withOpacity(0.05),
              AppTheme.background,
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: _Header()),
              SliverPadding(
                padding: const EdgeInsets.all(24),
                sliver: SliverToBoxAdapter(child: _HeroBanner()),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverToBoxAdapter(child: _UpcomingMatchesCard()),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 30, 24, 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'VÍDEOS E GOLS',
                        style: GoogleFonts.outfit(
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                          color: Colors.white.withOpacity(0.4),
                        ),
                      ),
                      Text(
                        'VER TUDO',
                        style: GoogleFonts.outfit(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.emerald500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 190,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: const [
                      _VideoCard(
                        imageUrl: 'https://images.unsplash.com/photo-1543351611-58f69d7c1781?auto=format&fit=crop&q=80&w=600',
                        title: 'Melhores momentos: Brasil vs França',
                      ),
                      _VideoCard(
                        imageUrl: 'https://images.unsplash.com/photo-1543351611-58f69d7c1781?auto=format&fit=crop&q=80&w=601',
                        title: 'Todos os gols da fase de grupos',
                      ),
                      _VideoCard(
                        imageUrl: 'https://images.unsplash.com/photo-1543351611-58f69d7c1781?auto=format&fit=crop&q=80&w=602',
                        title: 'As maiores defesas até agora',
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 30, 24, 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'NOTÍCIAS',
                        style: GoogleFonts.outfit(
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                          color: Colors.white.withOpacity(0.38),
                        ),
                      ),
                      Text(
                        'VER TUDO',
                        style: GoogleFonts.outfit(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.emerald500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    const [
                      SizedBox(height: 6),
                      _NewsCard(
                        tag: 'FAVORITO',
                        time: '2h atrás',
                        title: 'Brasil lidera as casas de aposta para o título',
                        imageUrl: 'https://images.unsplash.com/photo-1508609349937-5ec4ae374ebf?auto=format&fit=crop&q=80&w=600',
                      ),
                      SizedBox(height: 12),
                      _NewsCard(
                        tag: 'ÚLTIMA',
                        time: '5h atrás',
                        title: 'Sede da grande final confirmada: NY será palco',
                        imageUrl: 'https://images.unsplash.com/photo-1504754524776-8f4f37790ca0?auto=format&fit=crop&q=80&w=600',
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 36)),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'COPA DO MUNDO 2026',
                style: GoogleFonts.outfit(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1,
                  color: Colors.white,
                ),
              ),
              Text(
                'OFFICIAL KICK-OFF',
                style: GoogleFonts.outfit(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 4,
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
            ],
          ),
          Row(
            children: const [
              _HeaderButton(icon: FontAwesomeIcons.magnifyingGlass),
              SizedBox(width: 12),
              _HeaderButton(icon: FontAwesomeIcons.bell, hasNotification: true),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 212,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(36),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF79D122), Color(0xFF3A8E15), Color(0xFF163F0E)],
                  stops: [0.0, 0.58, 1.0],
                ),
              ),
            ),
            Positioned.fill(
              child: Opacity(
                opacity: 0.18,
                child: CustomPaint(
                  painter: _FieldStripePainter(),
                ),
              ),
            ),
            Positioned(
              right: -8,
              top: 18,
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.white.withOpacity(0.98),
                      const Color(0xFFD9E8EE),
                    ],
                    stops: const [0.2, 1.0],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.22),
                      blurRadius: 18,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: CustomPaint(
                  painter: _SoccerBallPainter(),
                ),
              ),
            ),
            Positioned(
              right: 6,
              top: -8,
              child: Transform.rotate(
                angle: 0.28,
                child: Container(
                  width: 78,
                  height: 22,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0C1420),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.26),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 92,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.76),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.82),
                    Colors.black.withOpacity(0.22),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.emerald500,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.emerald500.withOpacity(0.28),
                          blurRadius: 18,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Text(
                      'DESTAQUE',
                      style: GoogleFonts.outfit(
                        color: Colors.black,
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'CAMINHO ATÉ A GLÓRIA',
                    style: GoogleFonts.outfit(
                      fontSize: 27,
                      fontWeight: FontWeight.w900,
                      height: 0.88,
                      letterSpacing: -1.0,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Acompanhe cada momento da maior competição do planeta.',
                    style: GoogleFonts.outfit(
                      fontSize: 13.5,
                      color: Colors.white.withOpacity(0.66),
                      fontWeight: FontWeight.w600,
                      height: 1.18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FieldStripePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    const stripeWidth = 26.0;
    for (double x = -size.height; x < size.width + size.height; x += stripeWidth * 2) {
      final path = Path()
        ..moveTo(x, 0)
        ..lineTo(x + stripeWidth, 0)
        ..lineTo(x + stripeWidth + size.height, size.height)
        ..lineTo(x + size.height, size.height)
        ..close();
      canvas.drawPath(path, paint);
    }

    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.22)
      ..strokeWidth = 2;
    canvas.drawLine(Offset(size.width * 0.12, size.height * 0.44), Offset(size.width * 0.86, size.height * 0.44), linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SoccerBallPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.shortestSide * 0.28;

    final outerPaint = Paint()
      ..color = const Color(0xFF1A1A1A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;
    canvas.drawCircle(center, radius, outerPaint);

    final pentagonPaint = Paint()
      ..color = const Color(0xFF1A1A1A)
      ..style = PaintingStyle.fill;
    final pentagon = Path()
      ..moveTo(center.dx, center.dy - radius * 0.36)
      ..lineTo(center.dx + radius * 0.34, center.dy - radius * 0.1)
      ..lineTo(center.dx + radius * 0.2, center.dy + radius * 0.32)
      ..lineTo(center.dx - radius * 0.2, center.dy + radius * 0.32)
      ..lineTo(center.dx - radius * 0.34, center.dy - radius * 0.1)
      ..close();
    canvas.drawPath(pentagon, pentagonPaint);

    final seamPaint = Paint()
      ..color = const Color(0xFF1A1A1A).withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius * 0.82), 0.2, 1.0, false, seamPaint);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius * 0.82), 2.0, 1.0, false, seamPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _UpcomingMatchesCard extends StatefulWidget {
  const _UpcomingMatchesCard();

  @override
  State<_UpcomingMatchesCard> createState() => _UpcomingMatchesCardState();
}

class _UpcomingMatchesCardState extends State<_UpcomingMatchesCard> {
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_started) {
      _started = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        context.read<MatchProvider>().loadUpcoming();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MatchProvider>(context);
    final upcoming = provider.upcoming;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.cardBg.withOpacity(0.92),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: AppTheme.borderSide),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'PRÓXIMOS JOGOS',
                style: GoogleFonts.outfit(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                  color: Colors.white.withOpacity(0.4),
                ),
              ),
              Icon(
                FontAwesomeIcons.chevronRight,
                size: 14,
                color: Colors.white.withOpacity(0.18),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (provider.isLoading)
            const SizedBox(height: 100, child: Center(child: CircularProgressIndicator()))
          else if (upcoming.isEmpty)
            const MatchCard(isLive: true)
          else
            Column(
              children: upcoming
                  .take(2)
                  .map((m) => Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: MatchCard(
                          isLive: m.status == MatchStatus.live,
                          match: m,
                        ),
                      ))
                  .toList(),
            ),
        ],
      ),
    );
  }
}

class _VideoCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  const _VideoCard({required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(left: 8, right: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(36),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF1E2A24), Color(0xFF0F1115)],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppTheme.emerald500.withOpacity(0.12),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.emerald500.withOpacity(0.25),
                              blurRadius: 12,
                            )
                          ],
                        ),
                        child: const Icon(FontAwesomeIcons.play, size: 12, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          title,
                          style: GoogleFonts.outfit(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NewsCard extends StatelessWidget {
  final String tag;
  final String time;
  final String title;
  final String imageUrl;

  const _NewsCard({required this.tag, required this.time, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.cardBg.withOpacity(0.92),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppTheme.borderSide),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 86,
              height: 66,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF1E2A24), Color(0xFF0F1115)],
                    ),
                  ),
                  child: const Icon(Icons.photo, color: Colors.white24, size: 32),
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.emerald500,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        tag,
                        style: GoogleFonts.outfit(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '• $time',
                      style: GoogleFonts.outfit(
                        color: Colors.white.withOpacity(0.36),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    height: 1.08,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderButton extends StatelessWidget {
  final IconData icon;
  final bool hasNotification;

  const _HeaderButton({required this.icon, this.hasNotification = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(icon, size: 18, color: Colors.white.withOpacity(0.6)),
          if (hasNotification)
            Positioned(
              right: 12,
              top: 12,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppTheme.emerald500,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.emerald500.withOpacity(0.5),
                      blurRadius: 10,
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
