import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final bool showDot;
  final String? trailingText;

  const SectionHeader({
    super.key,
    required this.title,
    this.showDot = false,
    this.trailingText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (showDot) ...[
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                ),
                const SizedBox(width: 8),
              ],
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.black,
                  letterSpacing: 1.5,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          if (trailingText != null)
            Text(
              trailingText!,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.black,
                color: Color(0xFF00E676),
                letterSpacing: 1,
              ),
            ),
        ],
      ),
    );
  }
}
